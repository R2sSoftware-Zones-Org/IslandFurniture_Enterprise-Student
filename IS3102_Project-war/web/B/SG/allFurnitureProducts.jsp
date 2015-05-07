<%@page import="HelperClasses.Furniture"%>
<%@page import="EntityManager.PromotionEntity"%>
<%@page import="EntityManager.FurnitureEntity"%>
<%@page import="EntityManager.Item_CountryEntity"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="EntityManager.MemberEntity"%>
<jsp:include page="checkCountry.jsp" />
<!--###-->
<%
    Boolean displayShoppingCartOption = false;
    MemberEntity member = (MemberEntity) (session.getAttribute("member"));
    if (member == null) {
        displayShoppingCartOption = false;
    } else {
        displayShoppingCartOption = true;
    }
%>
<html> <!--<![endif]-->
    <jsp:include page="header.html" />
    <body>
        <%
            List<Furniture> furnitures = (List<Furniture>) (session.getAttribute("furnitures"));
            //List<Item_CountryEntity> item_countryList = (List<Item_CountryEntity>) (session.getAttribute("item_countryList"));
            List<PromotionEntity> promotions = (List<PromotionEntity>) session.getAttribute("promotions");
        %>

        <div class="body">
            <jsp:include page="menu2.jsp" />
            <div class="body">
                <div role="main" class="main">
                    <section class="page-top">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12">
                                    <h2>Furnitures</h2>
                                </div>
                            </div>
                        </div>
                    </section>
                    <div class="container">

                        <div class="row">
                            <div class="col-md-6">
                                <h2 class="shorter"><strong>All Furnitures</strong></h2>
                            </div>
                        </div>
                        <div class="row">

                            <ul class="products product-thumb-info-list" data-plugin-masonry>

                                <%
                                    try {
                                        if (furnitures != null) {
                                            for (int i = 0; i < furnitures.size(); i++) {
                                %>

                                <li class="col-md-3 col-sm-6 col-xs-12 product">
                                    <span class="product-thumb-info">
                                        <span class="product-thumb-info-image">
                                            <span class="product-thumb-info-act">                                                
                                                <span class="product-thumb-info-act-left"><a href="furnitureProductDetails.jsp?sku=<%=furnitures.get(i).getSKU()%>"  style="color: white"><em>View Details</em></a></span>
                                            </span>
                                            <img alt="" class="img-responsive" src="../../..<%=furnitures.get(i).getImageUrl()%>">
                                        </span>

                                        <span class="product-thumb-info-content">

                                            <h4><%=furnitures.get(i).getName()%></h4>

                                            <span class="product-thumb-info-act-left"><em>Height: <%=furnitures.get(i).getHeight()%></em></span><br/>
                                            <span class="product-thumb-info-act-left"><em>Length: <%=furnitures.get(i).getLength()%></em></span><br/>
                                            <span class="product-thumb-info-act-left"><em>Width: <%=furnitures.get(i).getWidth()%></em></span><br/>
                                            <%
                                                String normalPrice = "$" + furnitures.get(i).getPrice() + "0 ";
                                                PromotionEntity promotion = null;
                                                String promoPrice = "";
                                                String furnitureID = furnitures.get(i).getId() + "";
                                                String SKU = furnitures.get(i).getSKU();
                                                String price = "";
                                                String name = furnitures.get(i).getName();
                                                String imageURL = furnitures.get(i).getImageUrl();
                                                if (promotions != null) {
                                                    for (int k = 0; k < promotions.size(); k++) {
                                                        if (promotions.get(k).getItem().getSKU().equals(SKU)) {
                                                            promotion = promotions.get(k);
                                                            promoPrice = "$" + (furnitures.get(i).getPrice() * (100 - promotion.getDiscountRate()) / 100) + "0 ";
                                                        }
                                                    }
                                                }
                                            %>
                                            <%if (promotion == null) {%>
                                            <span class="product-thumb-info-act-left"><em>Price: <%=normalPrice%></em></span>
                                            <%price = furnitures.get(i).getPrice() + "";
                                            } else {%>
                                            <span class="product-thumb-info-act-left"><em>Price: <%=promoPrice%></em></span>
                                            <%price = furnitures.get(i).getPrice() * (100 - promotion.getDiscountRate()) / 100 + "a";
                                                }%>
                                            <br/>
                                            <a href="furnitureProductDetails.jsp?sku=<%=SKU%>"><span class="product-thumb-info-act-left"><em>More Details</em></span></a>

                                        </span>
                                        <%
                                            if (displayShoppingCartOption == true) {
                                        %>

                                        <a href="../../ECommerce_AddFurnitureToListServlet?id=<%=furnitureID%>&SKU=<%=SKU%>&price=<%=price%>&name=<%=name%>&imageURL=<%=imageURL%>" data-toggle="modal" class="add-to-cart-product">                                                
                                            <input type="button" name="btnEdit" class="btn btn-primary btn-block" id="<%=furnitures.get(i).getSKU()%>" value="Add To Cart"/>
                                        </a>
                                        <%
                                            }
                                        %>
                                    </span>
                                </li>
                                <%
                                            }
                                        }
                                    } catch (Exception ex) {
                                        System.out.println(ex);
                                    }
                                %>

                            </ul>
                        </div>
                        <hr class="tall">
                    </div>
                </div>
            </div>
            <jsp:include page="footer.html" />
        </div>
    </body>
</html>
