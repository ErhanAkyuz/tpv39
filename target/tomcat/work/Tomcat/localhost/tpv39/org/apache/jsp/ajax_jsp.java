/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2022-03-09 10:57:49 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import commerce.catalogue.service.CatalogueManager;
import commerce.catalogue.domaine.modele.Article;
import commerce.catalogue.domaine.modele.Livre;
import commerce.catalogue.domaine.modele.Musique;
import commerce.catalogue.domaine.modele.Piste;
import java.util.Iterator;
import java.util.List;

public final class ajax_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

    
    String saisie = request.getParameter("val");
//    out.print(saisie + "<br/>");
    
    if (session.getAttribute("panier") == null) {
        response.sendRedirect("./index.jsp");
    } else {
        CatalogueManager catalogueManager = (CatalogueManager) application
                .getAttribute("catalogueManager");
        
        List<Article> allArticles = catalogueManager.getArticles();
        List<Article> articles =  null;
        for (int i = 0; i < allArticles.size(); i++) {
            if (allArticles.get(i).getTitre().compareTo(saisie) <=5) {
                articles.add(allArticles.get(i));
                out.print(allArticles.get(i).getTitre().compareTo(saisie));
            }
        }
        Iterator<Article> listeDesArticles;
        Livre livre = null;
        Musique musique = null;
        Article article;
        
        
        listeDesArticles = articles.iterator();
        int index = 0;
        while (listeDesArticles.hasNext()) {
                article = (Article) listeDesArticles.next();
            if ((index % 3) == 0) {

      out.write("\r\n");
      out.write("<li class=\"product type-product first\">\r\n");
      out.write("        ");

											} else {

      out.write("\r\n");
      out.write("<li class=\"product type-product\">\r\n");
      out.write("    ");

        }
        index++;
    
      out.write("\r\n");
      out.write("    <a\r\n");
      out.write("            href=\"");
      out.print(response.encodeURL("./controlePanier.jsp?refArticle="+ article.getRefArticle()+ "&amp;commande=ajouterLigne"));
      out.write("\">\r\n");
      out.write("        <img src=\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");
 if (article.getImage().startsWith("http"))
													out.print(article.getImage()) ;
												else
													out.print("./images/"+article.getImage()) ; 
      out.write("\"\r\n");
      out.write("             class=\"attachment-shop_catalog wp-post-image\" alt=\"poster_2_up\"\r\n");
      out.write("             height=\"300\"/>\r\n");
      out.write("        \r\n");
      out.write("        <h3>");
      out.print(article.getTitre());
      out.write("\r\n");
      out.write("        </h3>\r\n");
      out.write("        <span class=\"price\">\r\n");
      out.write("            <ins>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<span class=\"amount\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t");
      out.print(article.getPrix());
      out.write(" â¬</span>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</ins>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</span>\r\n");
      out.write("    \r\n");
      out.write("    </a>\r\n");
      out.write("    <a\r\n");
      out.write("            href=\"");
      out.print(response.encodeURL("./controlePanier.jsp?refArticle="+ article.getRefArticle()+ "&amp;commande=ajouterLigne"));
      out.write("\"\r\n");
      out.write("            class=\"button add_to_cart_button product_type_simple\">Mettre dans le panier</a>\r\n");
      out.write("    ");

        if (article instanceof Musique) {
            musique = (Musique) article;
            if (musique.getPistes().size() > 0) {
    
      out.write("\r\n");
      out.write("    <div id=\"jquery_jplayer_");
      out.print(article.getRefArticle());
      out.write("\" class=\"jp-jplayer\"></div>\r\n");
      out.write("    <div id=\"jp_container_");
      out.print(article.getRefArticle());
      out.write("\" class=\"jp-audio\" role=\"application\">\r\n");
      out.write("        <div class=\"jp-type-playlist\">\r\n");
      out.write("            <div class=\"jp-gui jp-interface\">\r\n");
      out.write("                <div class=\"jp-controls-holder\">\r\n");
      out.write("                    <div class=\"jp-controls\">\r\n");
      out.write("                        <button class=\"jp-previous\" role=\"button\" tabindex=\"0\">previous</button>\r\n");
      out.write("                        <button class=\"jp-play\" role=\"button\" tabindex=\"0\">play</button>\r\n");
      out.write("                        <button class=\"jp-stop\" role=\"button\" tabindex=\"0\">stop</button>\r\n");
      out.write("                        <button class=\"jp-next\" role=\"button\" tabindex=\"0\">next</button>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"jp-playlist\">\r\n");
      out.write("                <ul>\r\n");
      out.write("                    <li>&nbsp;</li>\r\n");
      out.write("                </ul>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"jp-no-solution\">\r\n");
      out.write("                <span>Update Required</span> To play the media you will need to\r\n");
      out.write("                either update your browser to a recent version or update your <a\r\n");
      out.write("                    href=\"http://get.adobe.com/flashplayer/\" target=\"_blank\">Flash\r\n");
      out.write("                plugin</a>.\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("    ");

            } // if
        } // if
    
      out.write("\r\n");
      out.write("</li>\r\n");

    } // while

      out.write("\r\n");
      out.write("\r\n");

    }

      out.write('\r');
      out.write('\n');
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}