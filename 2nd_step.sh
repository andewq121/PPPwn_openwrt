opkg install python3 python3-pip make 
+pip install -r requirements.txt
read -p 'fw version ' fw
make -C stage1 FW=$fw clean && make -C stage1 FW=$fw
make -C stage2 FW=$fw clean && make -C stage2 FW=$fw
python3 pppwn.py --interface=lan --fw=$fw
