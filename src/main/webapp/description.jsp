<%@ page pageEncoding="UTF-8"%>
<%@ include file="enTetePage.html"%>
<%@ page import="commerce.catalogue.service.CatalogueManager"%>
<%@ page import="commerce.catalogue.domaine.modele.Article"%>
<%@ page import="commerce.gestion.Panier"%>
<%@ page import="commerce.gestion.LignePanier"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.UUID"%>
<%
	if (session.getAttribute("panier") == null) {
		response.sendRedirect("./index.jsp");
	} else {
		Panier lePanier = (Panier) session.getAttribute("panier");
		CatalogueManager catalogueManager = (CatalogueManager) application
				.getAttribute("catalogueManager");
%>
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
				<li class="page_item page-item-1">
					<a href="<%=response.encodeURL("./afficheRecherche.jsp")%>">Rechercher un article</a>
				</li>
				<li class="page_item page-item-2 current_page_item focus">
					<a href="<%=response.encodeURL("./controlerPanier.jsp")%>">Description article</a>
				</li>
			</ul>
		</div>
	</nav>
</header>
<div id="content" class="site-content">
	<div class="col-full">
		<header class="entry-header">
			<h1 class="entry-title"> Description article</h1>
		</header><!-- .entry-header -->
		<div class="entry-content">
			<div class="woocommerce">
				
				<table class="shop_table shop_table_responsive cart woocommerce-cart-form__contents" cellspacing="0">
					<thead>
					<tr>
						<th class="product-thumbnail"></th>
					
						
							<th class="product-name">Produit</th>
						
							<th class="product-descirption">Description</th>
						
							<th class="product-price">Prix</th>
						
					</tr>
					</thead>
					<%
						Iterator it;
						Article unArticle;
						it = lePanier.getLignesPanier().iterator();
						LignePanier uneLignePanier;
						while (it.hasNext()) {
							uneLignePanier = (LignePanier) it.next();
							unArticle = uneLignePanier.getArticle();
						
					%>
					<tbody>
					
					
						<tr class="woocommerce-cart-form__cart-item cart_item">
						
							<td class="product-thumbnail">
								<img
									class="attachment-shop_thumbnail wp-post-image" width="145"
									height="145" alt="hoodie_4_front"
									src="<% if (unArticle.getImage().startsWith("http"))
														out.print(unArticle.getImage()) ;
													else
														out.print("./images/"+unArticle.getImage()) ; %>"
								/>
							</td>
							
							<td class="product-name">
								<%=unArticle.getTitre() + "\n Ref: "+ unArticle.getRefArticle()%>
							</td>
							<td class="product-description">
								<%if(unArticle.getDescription().equals(null)){
									out.print("Pas de description disponible");
								}else{
									out.print(unArticle.getDescription());
								}
								%>
							</td>
							<td class="product-price">
								<span class="amount">
									<%=uneLignePanier.getPrixUnitaire()%>€
								</span>
							</td>
							
						</tr>
					
					<tr>
						<td>
							<a href="<%=response.encodeURL("./controlePanier.jsp?refArticle="+ unArticle.getRefArticle()+ "&amp;commande=ajouterLigne")%>"
							   class="button add_to_cart_button product_type_simple">Mettre dans le panier</a>
						</td>
					</tr>
					<%
						}
					%>
					</tbody>
				</table>
				
				<div class="cart-collaterals">
					<div class="cross-sells"></div>
					<div class="cart_totals ">
					
					</div>
				</div>
			</div>
		</div>
	</div><!-- .col-full -->
</div><!-- #content -->
<%
	}
%>