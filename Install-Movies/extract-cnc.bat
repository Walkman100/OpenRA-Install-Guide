@echo off
IF NOT EXIST GDI95.zip (
..\utilities\wget "https://cncnz.com/_files/GDI95.zip"
)
IF NOT EXIST NOD95.zip (
..\utilities\wget "https://cncnz.com/_files/NOD95.zip"
)

..\utilities\unzip GDI95.zip GDI95.iso
..\utilities\unzip NOD95.zip NOD95.iso

echo Press enter to possibly download, then install extra music files...
pause

IF NOT EXIST CovertOps_ISO.zip (
..\utilities\wget "https://cncnz.com/_files/CovertOps_ISO.zip"
)

..\utilities\unzip CovertOps_ISO.zip
