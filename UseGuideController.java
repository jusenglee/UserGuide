package kr.koar.www.guide.useguide.web;

import kr.koar.www.main.login.service.SessionVO;
import org.apache.commons.text.StringEscapeUtils;
import org.jsoup.Jsoup;
import org.jsoup.parser.Parser;
import org.jsoup.safety.Safelist;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import egovframework.rte.fdl.property.EgovPropertyService;
import kr.koar.manage.koar.main.service.MngMainService;
import kr.koar.manage.useguide.service.MngUseGuideService;
import kr.koar.manage.useguide.service.PrcuseGuideVO;
import kr.koar.manage.useguide.web.MngUseGuideController;
import kr.koar.www.com.common.service.CommonService;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RequestMapping("/useguide")
@Controller
public class UseGuideController {
  
    @Resource(name = "mngMainService")
    private MngMainService mngMainService;
  
    @Resource(name = "commonService")
    private CommonService commonService;
    
    @Resource(name = "mngUseGuideService")
    private MngUseGuideService mngUseGuideService; 
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
  
    private static final Logger LOGGER = LoggerFactory.getLogger(MngUseGuideController.class);
    
    @RequestMapping("researcherUseGuide.do")
    public String researchUseGuide(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        SessionVO sessionVO = (SessionVO) session.getAttribute("sessionVO");
        if (sessionVO != null) {
            model.addAttribute("session", sessionVO);
        }
        // 사이드 메뉴 분기처리
        model.addAttribute("sideMenu", "useguide");
        return "/koar/guide/useguide/researcherUseGuide";
    }

    @RequestMapping("academicOrganUseGuide.do")
    public String academicOrganUseGuide(HttpServletRequest request, Model model) {
        // 사이드 메뉴 분기처리
        model.addAttribute("sideMenu", "useguide");
        return "/koar/guide/useguide/academicOrganUseGuide";
    }

    @RequestMapping("libraryUseGuide.do")
    public String tempLibrary(HttpServletRequest request, Model model) {
        // 사이드 메뉴 분기처리
        model.addAttribute("sideMenu", "useguide");
        return "/koar/guide/useguide/libraryUseGuide";
    }


    @RequestMapping("getStartedUserGuide.do")
    public String tempHelpCenter(@RequestParam(required = false, defaultValue = "NTSP02") String systemCode, HttpServletRequest request, Model model)throws Exception {
        //HttpSession session = request.getSession();
        //String localeValue = session.getAttribute("language") != null ? session.getAttribute("language").toString() : "ko";
        String localeValue = "ko";
        PrcuseGuideVO prcuseGuideVO = new PrcuseGuideVO();
        prcuseGuideVO.setSystemCode(systemCode);
        // 활용 가이드 전체 메뉴 목록 조회
        List<PrcuseGuideVO> useGuideMenuList = mngUseGuideService.selectUseGuideAllMenuList2(prcuseGuideVO);
        model.addAttribute("sideMenu", "useguide");
        model.addAttribute("locale", localeValue);
        model.addAttribute("useGuideMenuList", useGuideMenuList);

        return "/koar/guide/useguide/getStartedUserGuide";
    }
    
    /**
     * 활용 가이드 정보 조회 Ajax
     * 
     * @param prcuseGidSn
     * @param request
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping("helpDeskUseGuideAjax")
    public Map<String, Object> useGuideInfoAjax(@RequestParam(required = false) String prcuseGidSn,
        @RequestParam(required = false) String searchKeyword, HttpServletRequest request) throws Exception {
        //HttpSession session = request.getSession();
        //String localeValue = session.getAttribute("language") != null ? session.getAttribute("language").toString() : "ko";
        String localeValue = "ko";
        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            if (searchKeyword != null && !searchKeyword.isEmpty()) {
              Map<String, Object> params = new HashMap<>();
              params.put("locale", localeValue);
              params.put("searchKeyword", searchKeyword);
              List<PrcuseGuideVO> searchResults = mngUseGuideService.seachMenu(params);
              for (PrcuseGuideVO prcuseGuideVO : searchResults) {
                if(prcuseGuideVO.getCnKor() != null && localeValue.equals("ko")) { 
                  prcuseGuideVO.setCnKor(Jsoup.clean(prcuseGuideVO.getCnKor(), Safelist.none()));
                  
                }
                if(prcuseGuideVO.getCnEng() != null && localeValue.equals("en")) { 
                  prcuseGuideVO.setCnEng(Jsoup.clean(prcuseGuideVO.getCnKor(), Safelist.none()));
                }
              }
              resultMap.put("useGuideInfo", searchResults);
            } else {
            // 기존 로직
              PrcuseGuideVO useGuideInfo = mngUseGuideService.selectUseGuideInfo(prcuseGidSn);
              resultMap.put("useGuideInfo", useGuideInfo);
            }
            resultMap.put("resultCode", "100");
        } catch(NullPointerException np) {
            np.printStackTrace();
            resultMap.put("resultCode", "-200");
        } catch(IOException ie) {
            ie.printStackTrace();
            resultMap.put("resultCode", "-200");
        } catch(Exception e) {
            e.printStackTrace();
            resultMap.put("resultCode", "-100");
        }
        
        return resultMap;
    }
}
