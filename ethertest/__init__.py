import __builtin__

def import_scapy():
    scapy_builtins = __import__("scapy.all",globals(),locals(),".").__dict__
    __builtin__.__dict__.update(scapy_builtins)

