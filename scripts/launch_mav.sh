# filepath: scripts/mavproxy.sh
#!/bin/bash
source ~/.bashrc

mavproxy.py \
  --master=udp:127.0.0.1:5760     \
  --out=udp:127.0.0.1:14550      \
  --console