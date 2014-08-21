
import os 
import glob

class BCStat: 
  
      basePath = '/sys/block/bcache0/bcache/stats_day' 
      csetPath = '/sys/fs/bcache/*-*-*'
  
      def __init__(self, title, file):
          self.title = title;
          self.name = file;
          self.last = "";
          self.changed = True;
          self.error = 0;
          self.append = ""
          
          if(not os.path.isdir(BCStat.basePath)):
            self.error = 1;
            
          self.basePath = BCStat.basePath
          
          if(not hasattr(BCStat, 'titleList')):
              BCStat.titleList = [];
              
          BCStat.titleList.append(title);
           
      
      def setAppend(self, txt):
          self.append = txt
          return self;
          
      def useCsetUidPath(self):
          self.basePath = glob.glob(BCStat.csetPath)[0]
          return self;
       
      @staticmethod
      def getTitleList():
        if(not hasattr(BCStat, 'titleList')):
             return []
        else:
             return BCStat.titleList
          
      def getLocation(self):
          return self.basePath + '/' + self.name;
        
      def getTitle(self):
          return self.title;
        
      def open(self):
          self.file = open(self.getLocation(), 'r')
        
      def close(self):
          self.file.close() 
        
      def isChanged(self, amount): 
          amount += self.append
          self.changed = (amount != self.last)
          self.last = amount;
          return self.changed;
        
      def refresh(self):
        
          if(self.error):
            return False
          
          self.open();
          line = self.file.readline().strip()
          self.close();
          return self.isChanged(line)
         