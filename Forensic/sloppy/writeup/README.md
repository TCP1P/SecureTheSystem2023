# sloppy (medium)

## description
So, I found an USB in my class, I took it and I put it in my laptop. Then i found interesting anime (the anime is in mp4) and rar file and I copied it on my laptop. When i tried to open the file it showed pop up that my computer has been comprimized and my laptop restared after 1 minutes and I immediately remove all file that've been copied to my computer. As an engineer i always capture usb traffic using wireshark. Please help me to figure out what's happening in my laptop.

wrap your flag with STS23{`<value>`}

## solution

1. Open the pcap file in wireshark
2. Because it mention about rar file, we can filter it using `usbms contains "Rar"`
3. After analyzing rar file the file seems want to be exploiting CVE-2023-38831
4. Analyze batch script that is used to exploit the CVE and we can see that it change the startup registry value

## flag

flag = STS23{C0mPrem1zed_d3sktop_h3h3}