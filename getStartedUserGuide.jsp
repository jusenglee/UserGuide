<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<link rel="stylesheet" href='<c:url value="/css/accesson.css" />'>
	<script src="<c:url value="/js/jquery-1.11.3.min.js" />"></script>
    <script src="<c:url value="/js/jquery-ui.js" />"></script>
    <script type="text/javascript" src='<c:url value="/js/bootstrap.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/js/bootstrap.bundle.min.js"/>'></script>

    <script type="text/javascript" src='<c:url value="/js/jquery.scroll.pack.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/js/common.js" />'></script><!--공통-->

    <!-- Slidebars CSS -->
    <%-- <link rel="stylesheet" href="<c:url value='/css/slidebars.css'/>" /> --%>
    <script src="<c:url value='/js/slidebars.js'/>"></script>
    <!-- Owl Carousel Assets -->
    <link href="<c:url value='/css/owl.carousel.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/css/owl.theme.default.min.css'/>" rel="stylesheet">
    <script src="<c:url value='/js/owl.carousel.js'/>"></script>
    <style type="text/css">
		.modal-body {
			max-height: 600px; /* or any height you prefer */
			overflow-y: auto;
		}
	</style>
</head>
<div class="container" style="padding-top: 30px; padding-bottom: 30px;">
	<input type="hidden" name="prcuseGidSn" id="prcuseGidSn" value="" />
	<input type="hidden" name="lvel" id="lvel" value="" />
	<div class="s_c_inner nav_left_inner">
		<div class="s_col_contents">
			<div class="r_b_line">
				<div class="h_g_h3_tit">
					<h3 class="sub_h3" id="upperMenuNm"></h3>
					<a href="#" class="round_bt sm_bt" data-bs-toggle="modal" data-bs-target="#HelpGuideSerch">
						<span class="r_b_search" style="line-height: 25px;">Search</span>
					</a>
				</div>
				<div class="modal fade" id="HelpGuideSerch" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5><spring:message code="jsp.get-started.user-guide.search" text="활용가이드 검색"/></h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="guide_search_box">
                                            <div class="guide_search_inner">
                                                <input id="searchKeyword" type="text" class="s_s_int" title="검색" placeholder="<spring:message code="jsp.get-started.user-guide.Searchtext" text="활용 가이드 검색어를 입력해주세요"/>">
                                                <a href="#" name="seachBtn" class="s_s_bt">검색</a>
                                            </div>
                                        </div>
                                        <div id="textNon"></div>
                                        <div class="guide_s_r_box">
                                        	<h5 class="sub_h5 mb-4"><spring:message code="jsp.get-started.user-guide.title" text="활용 가이드 제목검색"/></h5>
                                            <ul id="listTitle">
                                            	<li><spring:message code="jsp.get-started.user-guide.noneSearch" text="활용 가이드 검색 결과가 없습니다."/></li>
                                            </ul>

                                            <div class="guide_s_r_bottom">
                                            	<h5 class="sub_h5 mb-4"><spring:message code="jsp.get-started.user-guide.searchContent" text="활용 가이드 내용검색"/></h5>
                                            	<div id="listContent">
                                            		<spring:message code="jsp.get-started.user-guide.noneSearch" text="활용 가이드 검색 결과가 없습니다."/>
                                            	</div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <a href="#" class="round_bt" data-bs-dismiss="modal">Close</a>
                                        <a href="#" name="seachBtn" class="round_bt" id="round_btn">Search</a>
                                    </div>
                                </div>
                            </div>
				</div>
				<div class="h_g_inner" id="editorKor" name="editorKor">
					<h5 class="sub_h5 mb-4" id="menuNmKor"></h5>
					<div id="content"></div>
				</div>
			</div>
		</div>
		<div class="right_nav_wrap2">
			<div class="right_nav_fixed">

				<div class="right_nav_inner">
					<div class="r_n_title add_logo_tit">
						<br>
						<spring:message code="jsp.get-started.title.user-guide" text="활용가이드"/>
					</div>
					<ul>
						<c:forEach var="useGuideMenu" items="${useGuideMenuList}" varStatus="state">
							<li class="nav_add_sub">
								<a href="#" data-sn="<c:out value="${useGuideMenu.prcuseGidSn}"/>" data-lvel="0">
									<c:choose>
										<c:when test="${locale eq 'ko'}">${useGuideMenu.menuNmKor}</c:when>
										<c:otherwise>${useGuideMenu.menuNmEng}</c:otherwise>
									</c:choose>
								</a>
								<ul>
									<c:forEach var="subUseGuideMenuLv1" items="${useGuideMenu.subUseGuideList}" varStatus="stateLv1">
										<li class="nav_2depth_li">
											<a href="#" data-sn="<c:out value="${subUseGuideMenuLv1.prcuseGidSn}"/>" data-lvel="1">
												<c:choose>
													<c:when test="${locale eq 'ko'}">${subUseGuideMenuLv1.menuNmKor}</c:when>
													<c:otherwise>${subUseGuideMenuLv1.menuNmEng}</c:otherwise>
												</c:choose>
											</a>
											<ul>
												<c:forEach var="subUseGuideMenuLv2" items="${subUseGuideMenuLv1.subUseGuideList}" varStatus="stateLv2">
													<li class="nav_3depth_li">
														<a href="#" data-sn="<c:out value="${subUseGuideMenuLv2.prcuseGidSn}"/>" data-lvel="2">
															<c:choose>
																<c:when test="${locale eq 'ko'}">${subUseGuideMenuLv2.menuNmKor}</c:when>
																<c:otherwise>${subUseGuideMenuLv2.menuNmEng}</c:otherwise>
															</c:choose>
														</a>
													</li>
												</c:forEach>
											</ul>
										</li>
									</c:forEach>
								</ul>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
<!--메뉴 클릭시 내용 가져오는 함수-->
 function fetchUseGuideInfo(prcuseGidSn) {
    $.ajax({
        type: "POST",
        url: "<c:url value='/useguide/helpDeskUseGuideAjax' />",
        data: {
            "prcuseGidSn": prcuseGidSn
        },
        dataType: "json",
        cache: false,
        success: function(data) {
            if (data.resultCode == "100") {
            	var locale = "${locale}";
                var useGuideInfo = data.useGuideInfo;
                // 정보 세팅
                if(locale === 'ko'){
                	$("#upperMenuNm").text(useGuideInfo.upperMenuNmKor);
                }else{
                	$("#upperMenuNm").text(useGuideInfo.upperMenuNmEng);
                }
                if(!useGuideInfo.upperMenuNmKor || useGuideInfo.upperMenuNmKor === ""){
                	if(locale === 'ko'){
               			$("#upperMenuNm").text(useGuideInfo.menuNmKor);
                	}else{
                		$("#upperMenuNm").text(useGuideInfo.menuNmEng);
                	}
                }
                if(locale === 'ko'){
	                $("#menuNmKor").text(useGuideInfo.menuNmKor);
	                $("#content").html(useGuideInfo.cnKor);
                }else{
                	$("#menuNmKor").text(useGuideInfo.menuNmEng);
	                $("#content").html(useGuideInfo.cnEng);
                }
            }
        },
        error: function(request, status, error) {
        	if(locale === 'ko'){
            	$("#msg").text("조회 중 에러가 발생하였습니다.");
        	}else{
        		$("#msg").text("Error occurred during inquiry.");	
        	}
            $('#dialog').dialog('open');
        }
    });
}
 <!--/메뉴 클릭시 내용 가져오는 함수-->
 
 <!--메뉴 클릭 화면처리-->
$(document).ready(function() {
	// 초기 설정
    $("li > ul").hide();
    $('#firstTap').addClass('on');

    function processMenu($element) {
        var lvel = $element.data('lvel');
        var submenu = $element.next("ul");
        
        // 모든 메뉴의 활성 상태 제거
        $("a").removeClass('on');
        // 현재 메뉴 활성화
        $element.addClass('on');
        $element.parent().addClass('active');
        if (!submenu.is(":visible")) {
            submenu.slideToggle();
            $element.parent().siblings().find("ul:visible").slideUp().parent().removeClass('active');
        }

        // 데이터 로드
        var prcuseGidSn = $element.data("sn");
        $("#prcuseGidSn").val(prcuseGidSn);
        fetchUseGuideInfo(prcuseGidSn);
    }

    // 메뉴 클릭 처리 함수
    function handleMenuClick(e) {
        e.preventDefault();
        processMenu($(this));
    }

    // 메뉴 클릭 이벤트 리스너
    $("a[data-lvel]").click(handleMenuClick);
	<!--/메뉴 클릭 화면처리-->
	
	<!--외부 URL 접근 함수-->
	function activateMenuFromHash() {
        const menu = window.location.hash.replace('#', '');
        var cleanHref = window.location.href.split('#')[0];
        window.history.replaceState(null, null, cleanHref);
        
        if (menu) {
            var targetMenu = $("a[data-sn='" + menu + "']").first();
            var firstDepthMenu = targetMenu.closest('li.nav_add_sub').children("a[data-lvel='0']");
            var secondDepthMenu = targetMenu.closest('li.nav_2depth_li').children("a[data-lvel='1']");
            
            if (firstDepthMenu.length > 0) {
            	processMenu(firstDepthMenu);
                setTimeout(() => {
                    if (secondDepthMenu.length > 0) {
                        processMenu(secondDepthMenu);
                        setTimeout(() => {
                            processMenu(targetMenu);
                        }, 100);
                    }
                }, 100);
            }
        } else {
            processMenu($("a[data-lvel='0']").first());
        }
    }

    activateMenuFromHash();
    $(window).on('hashchange', activateMenuFromHash);
	<!--/외부 URL 접근 함수-->
	    
		<!--검색 관련 기능-->
	    function searchSubMenu() {
	        $('#listTitle').empty();
	        $('#listContent').empty();
	        var query = $('#searchKeyword').val().toUpperCase();

	        $.ajax({
	            type: "get",
	            url: "<c:url value='/useguide/helpDeskUseGuideAjax' />",
	            data: { searchKeyword: query },
	            dataType: "json",
	            cache: false,
	            success: function(data) {
	                if (data.resultCode == "100") {
	                	var locale = "${locale}";
	                	var useGuideInfo = data.useGuideInfo;
	                	// 검색 결과가 없는 경우
	                    if (!useGuideInfo || useGuideInfo.length === 0) {
	                    	$('#listTitle').append('<li><spring:message code="jsp.get-started.user-guide.noneSearch" text="활용 가이드 검색 결과가 없습니다."/></li>');
	                        $('#listContent').append('<spring:message code="jsp.get-started.user-guide.noneSearch" text="활용 가이드 검색 결과가 없습니다."/>');
	                    }else{
	                        var hasContent = useGuideInfo.some(menu => menu.searchCategory === 'Content');
	                        var hasTitle = useGuideInfo.some(menu => menu.searchCategory === 'Title' || menu.searchCategory === 'None');

	                        if (!hasTitle) {
	                            $('#listTitle').append('<li><spring:message code="jsp.get-started.user-guide.noneSearch" text="활용 가이드 검색 결과가 없습니다."/></li>');
	                        }
	                        
	                        if (!hasContent) {
	                            $('#listContent').append('<spring:message code="jsp.get-started.user-guide.noneSearch" text="활용 가이드 검색 결과가 없습니다."/>');
	                        }
	                    	
		                    var contents = [];
		                    var menuMap = {};
		                    var renderedUpperPrcuseGidSnSet = new Set();
	                    
		                    useGuideInfo.forEach(function(menu) { //content 검색 항목들을 변수에 할당
		                        if (menu.searchCategory == 'Title') {
		                            menu.children = [];
		                            menuMap[menu.prcuseGidSn] = menu;
		                        } 
		                        if (menu.searchCategory == 'Content') {
		                            contents.push(menu);
		                        }
		                    });
		                    
		                    var matchedMenus = useGuideInfo.filter(menu => {
		                        const target = locale === 'ko' ? menu.menuNmKor : menu.menuNmEng;
		                        return target && target.toLowerCase().includes(query.toLowerCase());
		                    });

		                    useGuideInfo.forEach(function(menu) {//Title 검색 항목들 중 동일한 상위 메뉴를 찾아 그룹화
		                    	if(menu.searchCategory == 'Title'){
			                        if (menu.upperPrcuseGidSn && menuMap[menu.upperPrcuseGidSn]) {
			                            if (!menuMap[menu.upperPrcuseGidSn].children.some(child => child.prcuseGidSn === menu.prcuseGidSn)) {
			                                menuMap[menu.upperPrcuseGidSn].children.push(menu);
			                            }
			                            
			                        } else if ((menu.lvel === '2' || menu.lvel === '1') && (!menuMap[menu.upperPrcuseGidSn])) {
			                            // 검색결과 중 상위메뉴가 없는 1, 2레벨의 메뉴들은 상위 메뉴를 새로 생성
			                            var upperMenu = {
									        prcuseGidSn: menu.upperPrcuseGidSn,
									        children: [],
									        menuNmKor: "",
									        menuNmEng: "",
									        searchCategory: 'Title',
									        lvel: menu.lvel - 1 //this 메뉴의 상위메뉴기에 더 높은 우선순위를 할당
									    };
									    
									    if (locale === 'ko') {
									        upperMenu.menuNmKor = menu.upperMenuNmKor;
									    } else {
									        upperMenu.menuNmEng = menu.upperMenuNmEng;
									    }
			                            menuMap[menu.upperPrcuseGidSn || menu.prcuseGidSn] = upperMenu;//만약 menu.prcuseGidSn, menu.upperPrcuseGidSn가 없는 객체면 삽입 X
			                            if (menu.upperPrcuseGidSn) {//만들어진 부모메뉴에 그룹핑
			                                upperMenu.children.push(menu);
			                            }
			                        }  
		                    }
		                    });
		                    function findAllTopLevelMenus(menu, menuMap) {//메뉴 출력시 우선순위별로 정렬
		                        if (menu.upperPrcuseGidSn && menuMap[menu.upperPrcuseGidSn]) {
		                            return findAllTopLevelMenus(menuMap[menu.upperPrcuseGidSn], menuMap);
		                        } else {
		                            return menu;
		                        }
		                    }
							
		                    var topLevelMenus = matchedMenus.map(menu => findAllTopLevelMenus(menu, menuMap));
		                    topLevelMenus = [...new Set(topLevelMenus)];
	
		                    function renderMenu(menu) {
		                    	
		                    	var isTopLevel = topLevelMenus.some(topMenu => menu.prcuseGidSn === topMenu.prcuseGidSn);
								if (isTopLevel) {
									iconClass = "g_s_r_icon";
	                    	    }else {
	                            // 하위 메뉴일 경우
	                            	iconClass = "g_s_r_icon g_s_r_icon02";
	                        	}
								if(locale === 'ko'){
									var html = '<li><span class="' + iconClass + '"></span><a href=' + '"getStartedUserGuide.do#' + menu.prcuseGidSn + '" onclick="closeModal()">' + menu.menuNmKor + '</a>';
								}else{
									var html = '<li><span class="' + iconClass + '"></span><a href=' + '"getStartedUserGuide.do#' + menu.prcuseGidSn + '" onclick="closeModal()">' + menu.menuNmEng + '</a>';
								}
								
		                        
		                        if (menu.children && menu.children.length > 0) {
		                            html += '<ul>';
		                            menu.children.forEach(function(childMenu) {
		                                html += renderMenu(childMenu, true);
		                            });
		                            html += '</ul>';
		                        }
	                        html += '</li>';
	                        return html;
		                    }
		                    function renderContent(content) {
		                    
		                    	if(locale === 'ko'){
		                        	return '<p style="margin-bottom: 5px"><span class="g_s_r_icon g_s_r_icon03"></span><a href=' + '"getStartedUserGuide.do#' + content.prcuseGidSn + '" onclick="closeModal()">' + content.cnKor + '... <storng style="color: #205bd2;"><span class="g_s_r_icon"></span>' + content.menuNmKor + '</storng></a></p>';
		                    	}else{
		                    		return '<p style="margin-bottom: 5px"><span class="g_s_r_icon g_s_r_icon03"></span><a href=' + '"getStartedUserGuide.do#' + content.prcuseGidSn + '" onclick="closeModal()">' + content.cnEng + '... <storng style="color: #205bd2;"><span class="g_s_r_icon"></span>' + content.menuNmEng + '</storng></a></p>';
		                    	}
		                    }
		                    var menuHtml = topLevelMenus.map(renderMenu).join('');
		                    var contentHtml = contents.map(renderContent).join('');
		                    $('#listTitle').html(menuHtml);
		                    $('#listContent').html(contentHtml);
		                    
	                	}
	              	}
	            },
	            error: function(error) {
	                // 오류가 발생했을 때 실행될 콜백 함수
	                console.error("Search error:", error);
	                alert("검색 중 오류가 발생했습니다.");
	            }
	        });
	    }

	    // 검색 버튼 클릭 이벤트 바인딩
	    $('a[name="seachBtn"]').on('click', function(e) {
	        e.preventDefault();
	        searchSubMenu();
	    });
	    //Enter바인딩
	    $('#searchKeyword').on('keydown', function(e) {
	        if (e.keyCode === 13) {
	            e.preventDefault();
	            searchSubMenu();
	        }
	    });

});
function closeModal() {
    // 모달을 닫는 코드
	$("#HelpGuideSerch").modal("toggle");
}
<!--/검색 관련 기능-->
</script>
<!--푸터-->

<!--//푸터-->