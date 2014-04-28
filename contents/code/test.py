import time
from BCStat import BCStat

class Foo:
    def __init__(self):
      self.files = {}; 
      self.files['cache_hits'] = BCStat('Cache Hits', 'cache_hits');
      self.files['cache_misses'] = BCStat('Cache Misses', 'cache_misses');
      self.files['cache_hit_ratio'] = BCStat('Cache Hit Ratio', 'cache_hit_ratio');
   
      self.files.get('cache_hits').refresh();
     
    def b(self):
      print self.files;
      print self.files['cache_hit_ratio'].refresh()
       
       
o = Foo();
o.b();