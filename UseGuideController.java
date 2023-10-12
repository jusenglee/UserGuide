@RequestMapping("/useguide")
@Controller
public class UseGuideController {
  
  

    @RequestMapping("UserGuide")
    public String tempHelpCenter(@RequestParam(required = false) String systemCode, HttpServletRequest request, Model model)throws Exception {
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
    @RequestMapping("Ajax")
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
