<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Bootstrap -->
    <link
	href="${pageContext.request.contextPath}/bootstrap-3.3.5-dist/css/bootstrap.min.css"
	rel="stylesheet">
	<link
		href="${pageContext.request.contextPath}/bootstrap-3.3.5-dist/css/bootstrap-theme.min.css"
		rel="stylesheet">
	<link 
	    rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css" media="screen" type="text/css" />
	<script
		src="${pageContext.request.contextPath}/bootstrap-3.3.5-dist/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.tmpl.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.cookie.js"></script>	
	<script type="text/javascript">
	       var i = null;
	       var j = 1;
	       var flag = null;
	
	       function hide(parentCatId)
			{  	    	  
			      document.getElementById("carousel-show").style.visibility = "hidden";         //设定隐藏
				  document.getElementById("carousel-show").style.height = 0; 
	              document.getElementById("data-show").style.display = "inline-block";        //显示控件
	              getBook(parentCatId);
			}  
	       function getBook(CatId){
	    	      var id = CatId;
	    	      flag = CatId;
	    	      i = null;
	    	      j = 1;
		    	   $.ajax({
						url : '${pageContext.request.contextPath}/toHomePage/getBook',
						data : {
							id : id ,
							page : 1
						},
						dataType : 'json',
						success : function(d) {
							$('#div_each').empty(); 
							$("#each").tmpl(d.rows).appendTo('#div_each');
							if (!i && typeof(i)!="undefined" && i!=0){
								i = d.total;								
							}
						}
					});
		    	   
		    	 
		    	   $.cookie('CatId', id);
	       }
	       
	       function getBookLater(j){
	    	   $.ajax({
					url : '${pageContext.request.contextPath}/toHomePage/getBook',
					data : {
						id : $.cookie('CatId'),
						page : j
					},
					dataType : 'json',
					success : function(d) {
						 
						$("#each").tmpl(d.rows).appendTo('#div_each');
						
					}
				});
	       }
	       
	       
	       
	       $(window).scroll(function(){  
	           //下面这句主要是获取网页的总高度，主要是考虑兼容性所以把Ie支持的documentElement也写了，这个方法至少支持IE8  
	           var htmlHeight=document.body.scrollHeight||document.documentElement.scrollHeight;  
	           //clientHeight是网页在浏览器中的可视高度，  
	           var clientHeight=document.body.clientHeight||document.documentElement.clientHeight;  
	           //scrollTop是浏览器滚动条的top位置，  
	           var scrollTop=document.body.scrollTop||document.documentElement.scrollTop;  
	           //通过判断滚动条的top位置与可视网页之和与整个网页的高度是否相等来决定是否加载内容；  
	           if(scrollTop+clientHeight==htmlHeight&&i!=0&&flag!=null){     
	        	  i = i - 1;
	        	  j = j + 1;
	        	  getBookLater(j);  
	            }
	       })  
	</script>	
</head>
<body>
	<div id="mymain">
        <nav class="navbar navbar-default">
          <div class="container-fluid">
            <div class="navbar-header">
               
            </div>
           </div>
           <div class="container" style="padding-top:5px;">    
                 <p>欢迎光临，请先<a>登录</a></p>
           </div>
        </nav>
       
        
      <div class="container" min-height="200px">        
        <nav class="navbar navbar-default navbar-inner">
          <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
              <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="#"><font color="#436EEE" size="+5">書享</font></a>
            </div>
            <div class="col-xs-3"></div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
              <ul class="nav navbar-nav">
               
              
              </ul>
              <form class="navbar-form navbar-left" role="search">
                <div>
                    <div class="input-group">
                      <input type="text" class="form-control" placeholder="Search for...">
                      <span class="input-group-btn">
                        <button class="btn btn-default" type="submit">搜索</button>
                      </span>
                    </div><!-- /input-group -->
                </div><!-- /.col-lg-6 -->
              </form>
              <ul class="nav navbar-nav navbar-right">
                <li><a href="#"><font color="#7F7F7F">我要发布</font></a></li>
                <li class="dropdown">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><font color="#7F7F7F">个人中心</font> <span class="caret"></span></a>
                  <ul class="dropdown-menu">
                    <li><a href="#">Action</a></li>
                    <li><a href="#">Another action</a></li>
                    <li><a href="#">Something else here</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="#">Separated link</a></li>
                  </ul>
                </li>
              </ul>
            </div><!-- /.navbar-collapse -->
          </div><!-- /.container-fluid -->
        </nav>
       
          
       <div class="row">
          <div class="col-xs-2">
              <div class="panel-group" id="accordion2">
                    <div class="panel-heading">
                        <strong style="font-size: 30px;">图书分类</strong>
                    </div>
                    <c:forEach items="${categoryItems}" var="myCategoryItems">
	                    <div class="panel panel-default">
	                        <div class="panel-heading" data-toggle="collapse"
	                            data-parent="#accordion2" href="#${myCategoryItems.parentItem}" onClick="hide('${myCategoryItems.parentId}')">
	                            <a class="accordion-toggle">${myCategoryItems.parentItem}</a>
	                            <input  id="parentCatId" type="hidden" name="parent_cat_id" value="${myCategoryItems.parentId}"> 
	                        </div>
	                        <div id="${myCategoryItems.parentItem}" class="panel-collapse collapse"
	                            style="height: 0px;">
	                            <div class="panel-body">
	                                <ul class="nav nav-pills nav-stacked">
	                                    <c:forEach items="${myCategoryItems.subItems}" var="mySubItems">
	                                        <li><a href="#" onClick="getBook('${mySubItems.id}')">${mySubItems.name}</a></li>
	                                        <input  id="subCatId" type="hidden" name="sub_cat_id" value="${mySubItems.id}"> 
	                                    </c:forEach>    
	                                </ul>
	                            </div>
	                        </div>
	                    </div>
                    </c:forEach> 
              </div>
          </div>
          
          <div class="col-xs-10">
              <div id="carousel-show" class="carousel slide" data-ride="carousel">
                  <!-- Indicators -->
                  <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                  </ol>
                
                  <!-- Wrapper for slides -->
                  <div class="carousel-inner" role="listbox">
                    <div class="item active">
                      <img src="${pageContext.request.contextPath}/images/1m.jpg" alt="...">
                      <div class="carousel-caption">
                        ...
                      </div>
                    </div>
                    <div class="item">
                      <img src="${pageContext.request.contextPath}/images/2m.jpg" alt="...">
                      <div class="carousel-caption">
                        ...
                      </div>
                    </div>
                    <div class="item">
                      <img src="${pageContext.request.contextPath}/images/3m.jpg" alt="...">
                      <div class="carousel-caption">
                        ...
                      </div>
                    </div>
                  </div>
                
                  <!-- Controls -->
                  <a class="left carousel-control" href="#carousel-show" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                  </a>
                  <a class="right carousel-control" href="#carousel-show" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                  </a>
                </div>
                <div id="data-show" style="display:none">
                   <hr style="height:10px;border:none;border-top:10px groove skyblue;" />
                   
		                  
                       
                        <div id="div_each"></div>
                        </div>
						<script id="each" type="text/x-jquery-tmpl"> 
                            
						        <div class="col-xs-4" style="padding-top:15px;">
		                          <div class="media-left media-middle">
		                            <a href="#">
		                              <img class="media-object bookimg" src="${pageContext.request.contextPath}/productImages/{{= productPic }}" alt="...">
		                            </a>
		                          </div>
		                          <div class="media-body">
		                            <h4 class="media-heading"><strong>{{= productName }}</strong></h4>
		                            <h5><strong>{{= keywords }}</strong></h5>
                                
                                    <h5 style="padding-top:10px;"><font color="#FF0000">￥ {{= dangPrice }}</font></h5>
		                            <br/>
		                            <p class="text-overflow">{{= description }}</p>
		                          </div>
		                        </div>
                              
	                     </script> 
					
                </div>
          </div>
       </div>
	  </div>  
     </div>
     
	 <footer class="myfooter">
		<hr/>
		  <div align="center">
			<div align="center">
			  &copy; 2016 | <a href="http://www.dzyngiri.com">Dzyngiri : Online Design Magazine</a> | <a href="http://twitter.github.com/bootstrap/" target="_blank">Bootstrap</a> | Demo Illustrations by <a href="http://justinmezzell.com" target="_blank">Justin Mezzell</a>
			</div>
		  </div>
	 </footer>
</body>
</html>