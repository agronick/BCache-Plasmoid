import time
from BCStat import BCStat

class Foo:
    def __init__(self):
        self.files = {}; 
        self.files['Status'] = BCStat('Status', '../running')
        self.files['Cache Hits'] = BCStat('Cache Hits', 'cache_hits')
        self.files['Cache Misses'] = BCStat('Cache Misses', 'cache_misses')
        self.files['Cache Hit Ratio'] = BCStat('Cache Hit Ratio', 'cache_hit_ratio')
        self.files['Bypassed Cache'] = BCStat('Bypassed Cache', 'bypassed')
        self.files['Cache Bypass Hits'] = BCStat('Cache Bypass Hits', 'cache_bypass_hits')
        self.files['Cache Bypass Misses'] = BCStat('Cache Bypass Misses', 'bypassed')
        self.files['Usable Cache Percent'] = BCStat('Usable Cache Percent', 'cache_available_percent')
        self.files['Usable Cache Percent'].useCsetUidPath()
        self.files['Usable Cache Percent'].setAppend('%')
        self.files['BTree Cache Size'] = BCStat('BTree Cache Size', 'btree_cache_size')
        self.files['BTree Cache Size'].useCsetUidPath()
        self.files['Root Btree Usage Percent'] = BCStat('Root Btree Usage Percent', 'root_usage_percent')
        self.files['Root Btree Usage Percent'].useCsetUidPath()
     
    def b(self): 
      print '\',\''.join(BCStat.getTitleList())
       
       
o = Foo();
o.b();