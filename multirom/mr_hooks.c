/*
 * This file contains device specific hooks.
 * Always enclose hooks to #if MR_DEVICE_HOOKS >= ver
 * with corresponding hook version!
 */

#include <stdio.h>
#include <unistd.h>
#include <dirent.h>
#include <ctype.h>
#include <string.h>
#include <sys/stat.h>

#include <errno.h>
#include <private/android_filesystem_config.h>
#include <fcntl.h>
#include <multirom.h>

#define GATEKEEPER_PATH "/system/vendor/lib64/hw/gatekeeper.msm8996.so"
#define GATEKEEPER_DATA_DIR "/data/misc/gatekeeper"
#define GATEKEEPER_COLDBOOT_PATH "/data/misc/gatekeeper/.coldboot"

#if MR_DEVICE_HOOKS >= 1

int mrom_hook_after_android_mounts(const char *busybox_path, const char *base_path, int type)
{
    // On m8, this fstab file is used to remount system to RO,
    // but with MultiROM, it remounts everything as RO, even /data and /cache
    if(access("/remount.qcom", F_OK) >= 0)
        remove("/remount.qcom");

    // remove mounting from .rc files
    int res = -1;
    int add_dummy = 0;
    char *l;
    char line[1024];
    char path_in[128];
    char path_out[128];
    FILE *in, *out;
    DIR *d;
    struct dirent *dp;

    d = opendir("/");
    if(!d)
        return -1;

    while((dp = readdir(d)))
    {
        if(dp->d_type != DT_REG || !strstr(dp->d_name, ".rc"))
            continue;

        snprintf(path_out, sizeof(path_out), "/%s", dp->d_name);
        snprintf(path_in, sizeof(path_in), "/%s.new", dp->d_name);

        if(rename(path_out, path_in) < 0)
            goto exit;

        in = fopen(path_in, "r");
        if(!in)
            goto exit;

        out = fopen(path_out, "w");
        if(!out)
        {
            fclose(in);
            goto exit;
        }

        while((fgets(line, sizeof(line), in)))
        {
            for(l = line; isspace(*l); ++l);

            if (strncmp(l, "on ", 3) == 0)
                add_dummy = 1;
            else if (strstr(l, "mount ") &&
                (strstr(l, "/data") || strstr(l, "/system") || strstr(l, "/cache")))
            {
                if(add_dummy == 1)
                {
                    add_dummy = 0;
                    fputs("    export DUMMY_LINE_INGORE_IT 1\n", out);
                }

                fputc((int)'#', out);
            }

            fputs(line, out);
        }

        fclose(out);
        fclose(in);
        remove(path_in);

        chmod(path_out, 0750);
    }

    // wiping the data of a primary or secondary ROM causes the ROM to delete
    // all lockscreen accounts from the gatekeeper on next boot, preventing
    // the user from logging into the other ROMs.
    // To work around this, create the .coldboot file to prevent the wipe.
    if (access(GATEKEEPER_COLDBOOT_PATH, F_OK) == -1)
    {
        // the permission should be fixed during the first boot
        int err = mkdir_recursive(GATEKEEPER_DATA_DIR, 0700);
        if (err)
            ERROR("failed to mkdir " GATEKEEPER_DATA_DIR ": %s", strerror(err));
        else
        {
            int fd = open(GATEKEEPER_COLDBOOT_PATH, O_WRONLY|O_TRUNC|O_CREAT,
                S_IRUSR|S_IWUSR);
            if (fd < 0)
                ERROR("failed to open " GATEKEEPER_COLDBOOT_PATH ": %s",
                    strerror(errno));
            else
            {
                fchown(fd, AID_SYSTEM, AID_SYSTEM);
                close(fd);
            }
        }
    }
    if (type == ROM_DEFAULT)
        return 0;
    // Delete the old gatekeeper workaround
    // remove after people stop using Beta 1-4
    remove(GATEKEEPER_PATH);
    return 0;

exit:
    closedir(d);
    return res;
}

#endif /* MR_DEVICE_HOOKS >= 1 */

#if MR_DEVICE_HOOKS >= 2
void mrom_hook_before_fb_close(void) { }
#endif

#if MR_DEVICE_HOOKS >= 3
void tramp_hook_before_device_init(void) { }
#endif

#if MR_DEVICE_HOOKS >= 4
int mrom_hook_allow_incomplete_fstab(void)
{
    return 1;
}
#endif
