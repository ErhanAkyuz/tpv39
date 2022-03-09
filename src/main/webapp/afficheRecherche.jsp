<%@ page pageEncoding="UTF-8" %>
<%@ include file="enTetePage.html" %>
<%@ page import="commerce.catalogue.service.CatalogueManager" %>
<%@ page import="commerce.catalogue.domaine.modele.Article" %>
<%@ page import="commerce.catalogue.domaine.modele.Livre" %>
<%@ page import="commerce.catalogue.domaine.modele.Musique" %>
<%@ page import="commerce.catalogue.domaine.modele.Piste" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("panier") == null) {
        response.sendRedirect("./index.jsp");
    } else {
        CatalogueManager catalogueManager = (CatalogueManager) application
                .getAttribute("catalogueManager");
        List<Article> articles = catalogueManager.getArticles();
        Iterator<Article> listeDesArticles;
        Livre livre = null;
        Musique musique = null;
        Article article;
%>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <script type="text/javascript">
        var xmlHttpRequest;

        function sendInfo(event) {
            // event.preventDefault();
            var num = document.testform.numText.value;
            var url = "ajax.jsp?val=" + num;
            console.log(url);
            if (window.XMLHttpRequest) {
                xmlHttpRequest = new XMLHttpRequest();
            } else if (window.ActiveXObject) {
                xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
            }

            try {
                xmlHttpRequest.onreadystatechange = getInfo;
                xmlHttpRequest.open("GET", url, true);
                xmlHttpRequest.send();
            } catch (e) {
                alert("Not able to connect to server");
            }
        }

        function getInfo() {
            if (this.readyState == 4 && this.status == 200) {
                var responseVal = xmlHttpRequest.responseText;
                document.getElementById('test').innerHTML = responseVal;
            }
        }

    </script>
</head>

<header id="header" class="col-full">
    <div id="logo">
        <h1 class="site-title">Site web marchand</h1>
    </div>
    <nav id="site-navigation" class="main-navigation" role="navigation">
        <button class="menu-toggle" aria-controls="site-navigation" aria-expanded="false">
            <span>Menu</span>
        </button>
        <div class="menu">
            <ul id="nav-menu">
                <li class="page_item page-item-1 current_page_item focus">
                    <a href="<%=response.encodeURL("./afficheRecherche.jsp")%>">Rechercher
                        un article</a>
                </li>
                <li class="page_item page-item-2">
                    <a href="<%=response.encodeURL("./controlePanier.jsp")%>">Panier</a>
                </li>
            </ul>
        </div>
    </nav>
    <div id="cse-search-results"></div>
    <script type="text/javascript"> var googleSearchIframeName = "cse-search-results";
    var googleSearchFormName = "cse-search-box";
    var googleSearchFrameWidth = 795;
    var googleSearchDomain = "www.google.fr";
    var googleSearchPath = "/cse"; </script>
    <script type="text/javascript" src="http://www.google.com/afsonline/show_afs_search.js"></script>

    <%--				<form action="http://www.votresiteinternet.fr/recherche.html" id="cse-search-box">--%>
    <%--					<div>--%>
    <%--						<input type="hidden" name="cx" value="partner-pub-7251150894597704:nz8345-k1u9" />--%>
    <%--						<input type="hidden" name="cof" value="FORID:9" />--%>
    <%--						<input type="hidden" name="ie" value="ISO-8859-1" />--%>
    <%--						<input name="sitesearch" value="www.votresiteinternet.fr" type="hidden">--%>
    <%--						<input type="text" name="q" size="31" />--%>
    <%--						<i class="fa fa-search" id="search"></i>--%>
    <%--&lt;%&ndash;						<input type="submit" name="sa" value="Rechercher" />&ndash;%&gt;--%>
    <%--					</div>--%>
    <%--					<!--  <script type="text/javascript" src="http://www.google.com/coop/cse/brand?form=cse-search-box&amp;lang=fr"></script> -->--%>
    <%--				</form>--%>

    <form name="testform">
        <input type="text" name="numText"/>
        <input type="button" value="Rehcherche" onClick="sendInfo()"/>
    </form>


</header>
<div id="content" class="site-content" tabindex="-1">
    <div class="col-full">
        <div id="primary" class="content-area">
            <main id="main" class="site-main" role="main">
                <header class="woocommerce-products-header">
                    <h1 class="woocommerce-products-header__title page-title">Résultats de la recherche</h1>
                </header>
                <ul class="products columns-3">
                    <p id="test"></p>
                    <%
                        listeDesArticles = articles.iterator();
                        int index = 0;
                        while (listeDesArticles.hasNext()) {
                            article = (Article) listeDesArticles.next();
                            if ((index % 3) == 0) {
                    %>
                    <li class="product type-product first">
                            <%
											} else {
%>
                    <li class="product type-product">
                        <%
                            }
                            index++;
                        %>
                        <a
                                href="<%=response.encodeURL("./controlePanier.jsp?refArticle="+ article.getRefArticle()+ "&amp;commande=ajouterLigne")%>">
                            <img src="
											<% if (article.getImage().startsWith("http"))
													out.print(article.getImage()) ;
												else
													out.print("./images/"+article.getImage()) ; %>"
                                 class="attachment-shop_catalog wp-post-image" alt="poster_2_up"
                                 height="300"/>

                            <h3><%=article.getTitre()%>
                            </h3>
                            <span class="price"><ins>
												<span class="amount">
													<%=article.getPrix()%> €</span>
											</ins>
										</span>

                        </a>
                        <a
                                href="<%=response.encodeURL("./controlePanier.jsp?refArticle="+ article.getRefArticle()+ "&amp;commande=ajouterLigne")%>"
                                class="button add_to_cart_button product_type_simple">Mettre dans le panier</a>
                        <%
                            if (article instanceof Musique) {
                                musique = (Musique) article;
                                if (musique.getPistes().size() > 0) {
                        %>
                        <div id="jquery_jplayer_<%=article.getRefArticle()%>" class="jp-jplayer"></div>
                        <div id="jp_container_<%=article.getRefArticle()%>" class="jp-audio" role="application">
                            <div class="jp-type-playlist">
                                <div class="jp-gui jp-interface">
                                    <div class="jp-controls-holder">
                                        <div class="jp-controls">
                                            <button class="jp-previous" role="button" tabindex="0">previous</button>
                                            <button class="jp-play" role="button" tabindex="0">play</button>
                                            <button class="jp-stop" role="button" tabindex="0">stop</button>
                                            <button class="jp-next" role="button" tabindex="0">next</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="jp-playlist">
                                    <ul>
                                        <li>&nbsp;</li>
                                    </ul>
                                </div>
                                <div class="jp-no-solution">
                                    <span>Update Required</span> To play the media you will need to
                                    either update your browser to a recent version or update your <a
                                        href="http://get.adobe.com/flashplayer/" target="_blank">Flash
                                    plugin</a>.
                                </div>
                            </div>
                        </div>
                        <%
                                } // if
                            } // if
                        %>
                    </li>
                    <%
                        } // while
                    %>
                </ul>
            </main>
        </div>
    </div><!-- .col-full -->
</div>
<!-- #content -->
<script type="text/javascript">
    window.addEventListener("load", myFunction, false);

    function myFunction(event) {
        <%
                            listeDesArticles = articles.iterator() ;
                            while (listeDesArticles.hasNext()) {
                                article = (Article) listeDesArticles.next();
                                if (article instanceof Musique) {
        %>
        var myPlaylist_<%=article.getRefArticle()%> = new jPlayerPlaylist({
            cssSelectorAncestor: "#jp_container_<%=article.getRefArticle()%>",
            jPlayer: "#jquery_jplayer_<%=article.getRefArticle()%>"
        }, [<%
				musique = (Musique) article;
							if (musique.getPistes().size() > 0) {
								Iterator<Piste> itPistes = musique.getPistes()
										.iterator();
								Piste unePiste;
								while (itPistes.hasNext()) {
									unePiste = itPistes.next();
%>
            {title: "<%=unePiste.getTitre().replace("\"", "\\\"" )%>", mp3: "<%=unePiste.getUrl()%>"}, <%

								}
							}
%>
        ], {
            swfPath: "/js/jplayer-2.9.2/jplayer", supplied: "mp3", wmode:
                "window", useStateClassSkin: true, autoBlur: false, smoothPlayBar: true,
            keyEnabled: true
        });
        <%

                                }
                            }
        %>
        var jp_playlist_tab = document.getElementsByClassName("jp-playlist");
        for (i = 0; i < jp_playlist_tab.length; i++) {
            jp_playlist_tab[i].style.display = "none";
        }
    }
</script>
<%
    }
%>
<%@ include file="piedDePage.html" %>