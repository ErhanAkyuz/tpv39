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
								<a href="<%=response.encodeURL("./afficheRecherche.jsp")%>">Rechercher
									un article</a>
							</li>
							<li class="page_item page-item-2 current_page_item focus">
								<a href="<%=response.encodeURL("./controlePanier.jsp")%>">Panier</a>
							</li>
						</ul>
					</div>
				</nav>
			</header>
			<div id="content" class="site-content">
				<div class="col-full">
					<header class="entry-header">
						<h1 class="entry-title">Panier</h1>
					</header><!-- .entry-header -->
					<div class="entry-content">
						<div class="woocommerce">
							<form
								action="<%=response
										.encodeURL("controlePanier.jsp?commande=recalculerPanier")%>"
								name="panier" method="post">
								<table class="shop_table shop_table_responsive cart woocommerce-cart-form__contents" cellspacing="0">
									<thead>
										<tr>
											<th class="product-remove"></th>
											<th class="product-thumbnail"></th>
											<th class="product-name">Produit</th>
											<th class="product-price">Prix</th>
											<th class="product-quantity">Quantité</th>
											<th class="product-subtotal">Total</th>
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
											<td class="product-remove"><a class="remove"
												title="Remove this item"
												href="<%=response
											.encodeURL("./controlePanier.jsp?refArticle="
													+ uneLignePanier.getArticle()
															.getRefArticle()
													+ "&amp;commande=supprimerLigne")%>">×</a>
											</td>
											<td class="product-thumbnail"><img
												class="attachment-shop_thumbnail wp-post-image" width="145"
												height="145" alt="hoodie_4_front"
												src="<% if (unArticle.getImage().startsWith("http")) 
													out.print(unArticle.getImage()) ;
												else
													out.print("./images/"+unArticle.getImage()) ; %>"/></td>
											<td class="product-name"><%=unArticle.getTitre()%></td>
											<td class="product-price">
												<span class="amount">
													<%=uneLignePanier.getPrixUnitaire()%>€
												</span>
											</td>
											<td class="product-quantity">
												<div class="quantity"><% String random = UUID.randomUUID().toString().replaceAll("-", ""); %>
													<label class="screen-reader-text" for="quantity_<%=random %>">Quantity</label>
													<input id="quantity_<%=random %>" class="input-text qty text" type="number"
														size="4" title="Qty" value="<%=uneLignePanier.getQuantite()%>"
														name="cart[<%=uneLignePanier.getArticle().getRefArticle()%>][qty]"
														min="1" step="1">
												</div>
											</td>
											<td class="product-subtotal">
												<span class="amount"><%=uneLignePanier.getPrixTotal()%>€</span>
											</td>
										</tr>
<%
											}
%>
										<tr>
											<td class="actions" colspan="6">
												<input class="button" type="submit" value="Mise à jour du panier" name="update_cart" /></td>
										</tr>
									</tbody>
								</table>
							</form>
							<div class="cart-collaterals">
								<div class="cross-sells"></div>
								<div class="cart_totals ">
									<h2>Total de la commande</h2>
									<table cellspacing="0">
										<tbody>
											<tr class="cart-subtotal">
												<th>Sous-total</th>
												<td>
													<span class="amount"><%=lePanier.getTotal()%>€</span>
												</td>
											</tr>
											<tr class="shipping">
												<th>Frais de port</th>
												<td>Gratuit</td>
											</tr>
											<tr class="order-total">
												<th>Total</th>
												<td>
													<strong>
														<span class="amount"><%=lePanier.getTotal()%>€</span>
													</strong>
												</td>
											</tr>
										</tbody>
									</table>
									<div class="wc-proceed-to-checkout">
										<a
											href="<%=response
										.encodeURL("./controleCommande.jsp?commande=effectuerCommander")%>"
											class="checkout-button button alt wc-forward">Effectuer la
											commande</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div><!-- .col-full -->
			</div><!-- #content -->
<%
	}
%>
<%@ include file="piedDePage.html"%>