// -*- coding: iso-8859-1 -*-
/*
 *   Author: Kyle Agronick <agronick@gmail.com>
 *   Date: Thu Apr 17 2014, 11:23:06
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 1.1
import org.kde.plasma.components 0.1 as PlasmaComponents  
import org.kde.plasma.core 0.1 as PlasmaCore   
import "plasmapackage:/code/main.js" as Main 


Item {
  
  id: mainParent 

    property int minimumWidth: 220
    property int minimumHeight: 290
   
  PlasmaCore.DataSource {
    id: dataSource
    engine: "BCacheBridge"
    connectedSources: sources
    interval: 4000
    onNewData:{ 
      if(sourceName == "Cache Hit Ratio")
      {
        ratio.text =  data.Value + "%";
        var calcWidth = (data.Value / 100) * gridWrapper.width;
        ratio.width = hitGraph.width = calcWidth;
      }else if(sourceName == "Status"){ 
        if(data.Value == "1")
        {
          enabledPic.source = enabledPic.on;
          enabledText.text = "Caching Enabled" 
          enabled = true;
        }else{
          enabledPic.source = enabledPic.off
          enabledText.text = "Caching Disabled" 
          enabled = false;
        }  
      }else if(enabled){  
        for(i=0; i<sources.length; i++)
        { 
          if(sources[i] == sourceName)
          {  
            dataDic = {'name': data.Title, 'value': data.Value}; 
            storageModel.set(i, dataDic);  
            break;
          }
        } 
        
      }
    }
  } 
  
  Rectangle{
    id:statusBox 
    width: mainParent.width 
    height: 40
    anchors.top: mainParent.top
    anchors.left: mainParent.left 
    
    color: "transparent"
    
    Image {
      x:4
      id: enabledPic 
      width:40
      height:40  
      property string on: "../images/ActivityMonitor.png"        
      property string off: "../images/ActivityRed.png" 
      cache:false
    }
    
    Text{ 
      id:enabledText
      x:50 
      anchors.verticalCenter:statusBox.verticalCenter 
      verticalAlignment:Text.AlignVCenter
      font.pointSize: 12
      font.bold:true
    }
    
  }
  Rectangle{
    id:gridWrapper 
    opacity: .6
    height:30
    width: statusBox.width 
    anchors.margins: 1 
    anchors.top: statusBox.bottom
    anchors.right: statusBox.right 
    anchors.left: statusBox.left 
    Item{
      id:middleWrapper
      anchors.fill: parent
      Rectangle{
        id:hitGraph
        width:50
        color: "#DDDDDD"
        anchors.top: parent.top 
        anchors.left:parent.left
        height:parent.height 
        Text {
          id: ratio  
          anchors.fill:parent
          horizontalAlignment:Text.AlignHCenter
          verticalAlignment:Text.AlignVCenter
        }
        Rectangle{
          anchors{
            right:parent.right
            top:parent.top
            bottom:parent.bottom
          }
          color:"orange"
          width:4
        }
      }
      
    }
    
  }
  Text{
    id:ratioText
    text:"Hit Ratio"
    font.bold:true
    font.pointSize: 10
    y:5
    height:20
    anchors.horizontalCenter:parent.horizontalCenter
    anchors.top:gridWrapper.bottom
    anchors.margins: 4 
  }
   Rectangle {
     id:recWrapper
     width: parent.width 
     color: "#EEE" 
     radius: 10  
     opacity: .7
    anchors{
      margins:8
      bottom:parent.bottom
      top:ratioText.bottom
      right:parent.right
      left:parent.left
    }
  Text{
    id:statsTitle
    text: "Daily Statistics"
      font.bold:true
        horizontalAlignment:Text.AlignHCenter
        
        width:parent.width
    anchors{
      topMargin:10
      top:parent.top
    }
  }
  
  ListView {
    id: storageListView
    anchors{
      margins:15
      top:statsTitle.bottom
      bottom:parent.bottom
      left:parent.left
      right:parent.right
    } 
    model: storageModel 
    width:parent.width 
    delegate:
    Row {  
      id:parentRow
      width:parent.width
      Text { text: name } 
      Text{text: value 
        horizontalAlignment:Text.AlignRight 
        anchors.right:parent.right
      }
    }
    
    
  }
  
 }
  
  ListModel{
    id:storageModel;
    
    //QT Requires the list to be prepopulated
    ListElement {name:""; value:""}
    ListElement {name:""; value:""}
    ListElement {name:""; value:""}
    ListElement {name:""; value:""}
    ListElement {name:""; value:""}
    ListElement {name:""; value:""}
    ListElement {name:""; value:""}
    ListElement {name:""; value:""}
    ListElement {name:""; value:""}
  }
  
} 
