class Message < ActiveRecord::Base

  RGB = [
    [ "#000000","#000033","#000066","#000099","#0000cc","#0000ff",
      "#006600","#006633","#006666","#006699","#0066cc","#0066ff",
      "#00cc00","#00cc33","#00cc66","#00cc99","#00cccc","#00ccff"
    ],
    [ "#003300","#003333","#003366","#003399","#0033cc","#0033ff",
      "#009900","#009933","#009966","#009999","#0099cc","#0099ff",
      "#00ff00","#00ff33","#00ff66","#00ff99","#00ffcc","#00ffff"
    ],
    [ "#330000","#330033","#330066","#330099","#3300cc","#3300ff",
      "#336600","#336633","#336666","#336699","#3366cc","#3366ff",
      "#33cc00","#33cc33","#33cc66","#33cc99","#33cccc","#33ccff"
    ],
    [ "#333300","#333333","#333366","#333399","#3333cc","#3333ff",
      "#339900","#339933","#339966","#339999","#3399cc","#3399ff",
      "#33ff00","#33ff33","#33ff66","#33ff99","#33ffcc","#33ffff"
    ],
    [ "#660000","#660033","#660066","#660099","#6600cc","#6600ff",
      "#666600","#666633","#666666","#666699","#6666cc","#6666ff",
      "#66cc00","#66cc33","#66cc66","#66cc99","#66cccc","#66ccff"
    ],
    [ "#663300","#663333","#663366","#663399","#6633cc","#6633ff",
      "#669900","#669933","#669966","#669999","#6699cc","#6699ff",
      "#66ff00","#66ff33","#66ff66","#66ff99","#66ffcc","#66ffff"
    ],
    [ "#990000","#990033","#990066","#990099","#9900cc","#9900ff",
      "#996600","#996633","#996666","#996699","#9966cc","#9966ff",
      "#99cc00","#99cc33","#99cc66","#99cc99","#99cccc","#99ccff"
    ],
    [ "#993300","#993333","#993366","#993399","#9933cc","#9933ff",
      "#999900","#999933","#999966","#999999","#9999cc","#9999ff",
      "#99ff00","#99ff33","#99ff66","#99ff99","#99ffcc","#99ffff"
    ],
    [ "#cc0000","#cc0033","#cc0066","#cc0099","#cc00cc","#cc00ff",
      "#cc6600","#cc6633","#cc6666","#cc6699","#cc66cc","#cc66ff",
      "#cccc00","#cccc33","#cccc66","#cccc99","#cccccc","#ccccff"
    ],
    [ "#cc3300","#cc3333","#cc3366","#cc3399","#cc33cc","#cc33ff",
      "#cc9900","#cc9933","#cc9966","#cc9999","#cc99cc","#cc99ff",
      "#ccff00","#ccff33","#ccff66","#ccff99","#ccffcc","#ccffff"
    ],
    [ "#ff0000","#ff0033","#ff0066","#ff0099","#ff00cc","#ff00ff",
      "#ff6600","#ff6633","#ff6666","#ff6699","#ff66cc","#ff66ff",
      "#ffcc00","#ffcc33","#ffcc66","#ffcc99","#ffcccc","#ffccff"
    ],
    [ "#ff3300","#ff3333","#ff3366","#ff3399","#ff33cc","#ff33ff",
      "#ff9900","#ff9933","#ff9966","#ff9999","#ff99cc","#ff99ff",
      "#ffff00","#ffff33","#ffff66","#ffff99","#ffffcc","#ffffff"
    ]
  ]
  SMILES = Array.new()
  SMILES[0] = 'sm1'
  for i in (1..254)
    SMILES[i] = 'sm' + i.to_s
  end

  SMILES_ON_MAIN = [
    "sm12","sm15","sm17","sm36","sm20","sm28","sm52","sm54","sm51",
    "sm35","sm19","sm38","sm40","sm67","sm57","sm31","sm33","sm5",
    "sm64","sm62","sm30","sm10","sm1"
  ]
  
  PARSER = [
     [  "<"     ,     "&lt;"  ],[  ">"      ,     "&gt;"  ],[  "\n"    ,     "<br>"  ],
     [  "[b]"   ,     "<b>"   ],[  "[/b]"   ,     "</b>"  ],
     [  "[i]"   ,     "<i>"   ],[  "[/i]"   ,     "</i>"  ],
     [  "[u]"   ,     "<u>"   ],[  "[/u]"   ,     "</u>"  ],
     [  "[s]"   ,     "<s>"   ],[  "[/s]"   ,     "</s>"  ],
     [  "[h1]"  ,     "<h1>"  ],[  "[/h1]"  ,     "</h1>" ],
     [  "[h2]"  ,     "<h2>"  ],[  "[/h2]"  ,     "</h2>" ],
     [  "[img]"  , "<img src='" ],[  "[/img]"  , "'>" ],
  ]


  belongs_to   :user
  has_many     :comments
  validates_presence_of   :user_name, :message => "Name can't be blank!"

  def self.safe_format(content)
    PARSER.each do |p|
        content = content.gsub(p[0].to_s,p[1].to_s)
    end
    if content.scan(":sm").size > 0
        SMILES_ON_MAIN.each do |s|
         content = content.gsub(":" + s.to_s + ":", "<img src='images/smiles/" + s.to_s + ".gif'>")
        end
    end
    if content.scan("[font color=").size > 0
        RGB.each do |row|
          row.each do |color|
            content = content.gsub("[font color=" + color.to_s + "]", "<span style='color:" + color.to_s + ";'>")
          end
        end
         content = content.gsub("[/font]","</span>")
    end
    content
  end
  def self.format_return(content)
    if content.scan("<img src='images/smiles/sm").size > 0
        SMILES_ON_MAIN.each do |s|
         content = content.gsub("<img src='images/smiles/" + s.to_s + ".gif'>" , ":" + s.to_s + ":")
        end
    end
    if content.scan("<span style='color:").size > 0
        RGB.each do |row|
          row.each do |color|
            content = content.gsub("<span style='color:" + color.to_s + ";'>" , "[font color=" + color.to_s + "]")
          end
        end
         content = content.gsub("</span>", "[/font]")
    end
    PARSER.reverse_each do |p|
        content = content.gsub(p[1].to_s,p[0].to_s)
    end
    content
  end
end
