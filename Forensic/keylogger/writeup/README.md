# keylogger (easy)

## description
So, here's the thing. I just came to the Internet caffee (warnet) and after several minutes using the computer, I found a strange process running in the backround. Then i found out it was a keylogger. Luckily I can stop the process and don't let the attacker get this keylogger file. Because i just logged in to my server before.

flag = STS23{`<my server password>`}

## solution

1. Filter pcap usb hid data using `tshark -r file.pcapng -Y '(usb.dst == "host") && (usbhid.data)' -T fields -e usbhid.data > data`
2. then just create python script to decode the data
3. flag is in the password of ssh

## flag

flag = STS23{th1smys3cretp@ssw0rd}