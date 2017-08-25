IF NOT EXIST GDI95.zip (
..\utilities\wget "http://cncnz.com/?smd_process_download=1&download_id=7585"
)
IF NOT EXIST NOD95.zip (
..\utilities\wget "http://cncnz.com/?smd_process_download=1&download_id=7586"
)

..\utilities\unzip GDI95.zip GDI95.iso
..\utilities\unzip NOD95.zip NOD95.iso

echo Press enter to possibly download, then install extra music files...
pause

IF NOT EXIST CovertOps_ISO.zip (
..\utilities\wget "http://cncnz.com/?smd_process_download=1&download_id=7711"
)

..\utilities\unzip CovertOps_ISO.zip
