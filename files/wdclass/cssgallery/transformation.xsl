<?xml version="1.0" standalone="no"?>


<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  

    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
        <title>Απλή photo gallery</title>
        <link href="style.css" rel="stylesheet" type="text/css" />
      </head>
      <body>

        <h1>Απλή photo gallery</h1>
        <div id="content">
          <h2>Επιλογές προβολής:</h2>
          <input type="radio" id="thumbnails" name="view" />
          <label for="thumbnails">Μικρογραφίες</label>

          <input type="radio" id="medium" name="view" checked="checked" />
          <label for="medium">Μεσαίο μέγεθος</label>

          <input type="radio" id="large" name="view" />
          <label for="large">Μεγάλο μέγεθος</label>

          <ul class="gallery">
            
            <xsl:template match="/">

              <xsl:apply-templates/>
              
            </xsl:template>
            
           </ul>
        </div>

        <p id="footer">
          &#169;2010 Οικονομικό Πανεπιστήμιο Αθηνών
          <small>
            Οι φωτογραφίες δημοσιεύτηκαν στο <a href="http://flickr.com">flickr</a> με δικαιώματα που επιτρέπουν τη διανομή τους για τις ανάγκες του μαθήματος
          </small>
        </p>

      </body>
    </html>
  
   <xsl:template match="/">

    <xsl:for-each select="//picture">

      <li>
        <img>
          <xsl:attribute name="src"><xsl:value-of select="//pictures/@dir"/><xsl:value-of select="filename"/>
          </xsl:attribute>  
          <xsl:attribute name="alt"><xsl:value-of select="@title"/> 
          </xsl:attribute>
        </img>
        <p>
          <a>
            <xsl:attribute name="href"><xsl:value-of select="link"/>
            </xsl:attribute> 
            <xsl:value-of select="@title"/>
          </a>
        </p>
      </li>
      
    </xsl:for-each>
      
  </xsl:template>
    
    
</xsl:stylesheet>
  