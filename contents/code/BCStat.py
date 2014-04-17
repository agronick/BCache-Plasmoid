
import os 

class BCStat:

      basePath = '/sys/block/sda/sda8/bcache/stats_day'
  
      def __init__(self, title, file):
          self.title = title;
          self.name = file;
          self.last = "";
          
      def getLocation(self):
          return BCStat.basePath + '/' + self.name;
        
      def getTitle(self):
          return self.title;
        
      def open(self):
          self.file = open(self.getLocation(), 'r')
        
      def close(self):
          self.file.close() 
        
      def isChanged(self, amount): 
          changed = (amount != self.last)
          self.last = amount;
          return changed;
        
      def refresh(self):
          line = self.file.readline().strip()
          return self.isChanged(line)
        
      def changedMessage(self):
          return self.title + "\'s new value is: " + self.last;
      