from ethertest import import_scapy

import_scapy()

def ping(src=None, dst="127.0.0.1"):
    if dst:
        p= IP(src=src, dst=dst)/ICMP(type="echo-request")
    else:
        p= IP(src=src)/ICMP(type="echo-request")

    return sr1(p, timeout=2)
