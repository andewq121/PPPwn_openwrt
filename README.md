# PPPwn - OpenwWrt for PlayStation 4 PPPoE RCE
PPPwn is a kernel remote code execution exploit for PlayStation 4 up to FW 11.00. This is a proof-of-concept exploit for [CVE-2006-4304](https://hackerone.com/reports/2177925) that was reported responsibly to PlayStation.

Supported versions are:
- FW 7.50 / 7.51 / 7.55
- FW 8.00 / 8.01 / 8.03
- FW 8.50 / 8.52
- FW 9.00
- FW 9.03 / 9.04
- FW 9.50 / 9.51 / 9.60
- FW 10.00 / 10.01
- FW 10.50 / 10.70 / 10.71
- FW 11.00
- more can be added (PRs are welcome)

The exploit only prints `PPPwned` on your PS4 as a proof-of-concept. In order to launch Mira or similar homebrew enablers, the `stage2.bin` payload needs to be adapted.

## Requirements
- Router with installed openwrt
- Usb flash for router memory
- Some skills

## Usage
I won't show you how to install openwrt, I'll give you a ready-made script
my router is configured in repeater mode(see video on youtube)

On your computer, install mobaxterm:
https://mobaxterm.mobatek.net/download-home-edition.html

![image](https://github.com/andewq121/PPPwn_openwrt/assets/168224103/bd4e9443-e0fc-440b-bcbb-775a98b5a76a)

session > SSH > enter router ip(I changed the router's IP so that there are no conflicts with the main routers in repeater mode)

![image](https://github.com/andewq121/PPPwn_openwrt/assets/168224103/40c84d30-99f7-4d2b-b997-7c551dff8c5b)

unpack my repository into a folder and move it to this folder

![image](https://github.com/andewq121/PPPwn_openwrt/assets/168224103/285bd8bb-6b02-4d1a-a78b-e84085335200)

```sh
cd PPPwn_openwrt-master/
```

and run script 1st_step.sh

```sh
sh 1st_step.sh
```

your router will reboot
check if the flash drive is detected

```sh
df /overlay /
```
your output should look like this

```sh
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda1              7760088     28120   7316276   0% /overlay
overlayfs:/overlay     7760088     28120   7316276   0% /

```

```sh
cd PPPwn_openwrt-master/
```

and run script 2ns_step.sh

```sh
sh 2nd_step.sh
```

the script will ask for your version

On your PS4:

- Go to `Settings` and then `Network`
- Select `Set Up Internet connection` and choose `Use a LAN Cable`
- Choose `Custom` setup and choose `PPPoE` for `IP Address Settings`
- Enter anything for `PPPoE User ID` and `PPPoE Password`
- Choose `Automatic` for `DNS Settings` and `MTU Settings`
- Choose `Do Not Use` for `Proxy Server`

- Now, simultaneously press the 'X' button on your controller on `Test Internet Connection` and 'Enter' on your keyboard (on the computer you have your Python script ready to run).

ALWAYS wait for you console to show the message "Cannot connect to network: (NW-31274-7)" before trying this PPOE injection again.

If the exploit fails or the PS4 crashes, you can skip the internet setup and simply click on `Test Internet Connection`. Kill the `pppwn.py` script and run it again on your computer, and then click on `Test Internet Connection` on your PS4: always simultaneously.


If the exploit works, you should see an output similar to below, and you should see `Cannot connect to network.` followed by `PPPwned` printed on your PS4, or the other way around. 

### Example run

```sh
[+] PPPwn - PlayStation 4 PPPoE RCE by theflow
[+] args: interface=enp0s3 fw=1100 stage1=stage1/stage1.bin stage2=stage2/stage2.bin

[+] STAGE 0: Initialization
[*] Waiting for PADI...
[+] pppoe_softc: 0xffffabd634beba00
[+] Target MAC: xx:xx:xx:xx:xx:xx
[+] Source MAC: 07:ba:be:34:d6:ab
[+] AC cookie length: 0x4e0
[*] Sending PADO...
[*] Waiting for PADR...
[*] Sending PADS...
[*] Waiting for LCP configure request...
[*] Sending LCP configure ACK...
[*] Sending LCP configure request...
[*] Waiting for LCP configure ACK...
[*] Waiting for IPCP configure request...
[*] Sending IPCP configure NAK...
[*] Waiting for IPCP configure request...
[*] Sending IPCP configure ACK...
[*] Sending IPCP configure request...
[*] Waiting for IPCP configure ACK...
[*] Waiting for interface to be ready...
[+] Target IPv6: fe80::2d9:d1ff:febc:83e4
[+] Heap grooming...done

[+] STAGE 1: Memory corruption
[+] Pinning to CPU 0...done
[*] Sending malicious LCP configure request...
[*] Waiting for LCP configure request...
[*] Sending LCP configure ACK...
[*] Sending LCP configure request...
[*] Waiting for LCP configure ACK...
[*] Waiting for IPCP configure request...
[*] Sending IPCP configure NAK...
[*] Waiting for IPCP configure request...
[*] Sending IPCP configure ACK...
[*] Sending IPCP configure request...
[*] Waiting for IPCP configure ACK...
[+] Scanning for corrupted object...found fe80::0fdf:4141:4141:4141

[+] STAGE 2: KASLR defeat
[*] Defeating KASLR...
[+] pppoe_softc_list: 0xffffffff884de578
[+] kaslr_offset: 0x3ffc000

[+] STAGE 3: Remote code execution
[*] Sending LCP terminate request...
[*] Waiting for PADI...
[+] pppoe_softc: 0xffffabd634beba00
[+] Target MAC: xx:xx:xx:xx:xx:xx
[+] Source MAC: 97:df:ea:86:ff:ff
[+] AC cookie length: 0x511
[*] Sending PADO...
[*] Waiting for PADR...
[*] Sending PADS...
[*] Triggering code execution...
[*] Waiting for stage1 to resume...
[*] Sending PADT...
[*] Waiting for PADI...
[+] pppoe_softc: 0xffffabd634be9200
[+] Target MAC: xx:xx:xx:xx:xx:xx
[+] AC cookie length: 0x0
[*] Sending PADO...
[*] Waiting for PADR...
[*] Sending PADS...
[*] Waiting for LCP configure request...
[*] Sending LCP configure ACK...
[*] Sending LCP configure request...
[*] Waiting for LCP configure ACK...
[*] Waiting for IPCP configure request...
[*] Sending IPCP configure NAK...
[*] Waiting for IPCP configure request...
[*] Sending IPCP configure ACK...
[*] Sending IPCP configure request...
[*] Waiting for IPCP configure ACK...

[+] STAGE 4: Arbitrary payload execution
[*] Sending stage2 payload...
[+] Done!
```

## Notes for Mac Apple Silicon Users (arm64 / aarch64)
The code will not compile on Apple Silicon and requires AMD64 architecture.
There is a workaround using docker which will build the bin files required.
Clone this repository to your mac system, then from the repo folder run `./build-macarm.sh`. This will build the binaries for PS4 FW 1100 and place the necessary files into the correct folders. To build the binaries for a different version, i.e. 900, run the command as such: `./build-macarm.sh 900`. Once built, copy this folder structure into the Linux VM and execute as instructed above.
This has been tested using VMware Fusion 13.5.1, with the VM Guest as Ubuntu 24.04, and the host machine is MacOS 14.4.1
