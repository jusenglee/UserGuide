# UserGuide
AccessOn 프로젝트에서 구현한 활용가이드
https://accesson.kisti.re.kr/useguide/getStartedUserGuide.do

MYbatis에서 사용된 SQL

	    /* seachMenu */
	    SELECT
	        PRCUSE_GID_SN       AS PRCUSEGIDSN,
	        UPPER_PRCUSE_GID_SN AS UPPERPRCUSEGIDSN,
	        <choose>
				<when test="locale == 'ko'">
			        (
			            SELECT
			                MENU_NM_KOR
			            FROM
			                KOAR_PRCUSE_GUIDE
			            WHERE
			                PRCUSE_GID_SN = G.UPPER_PRCUSE_GID_SN
			        )                   AS UPPERMENUNMKOR,			
	            </when>
	            <otherwise>
			        (
			            SELECT
			                MENU_NM_ENG
			            FROM
			                KOAR_PRCUSE_GUIDE
			            WHERE
			                PRCUSE_GID_SN = G.UPPER_PRCUSE_GID_SN
			        )                   AS UPPERMENUNMENG,
	            </otherwise>
	        </choose>
	        SYSTEM_CODE         AS SYSTEMCODE,
	        MENU_NM_ENG         AS MENUNMENG,
	        MENU_NM_KOR         AS MENUNMKOR,
	        CN_ENG              AS CNENG,
	        lvel                AS lvel,
	        <choose>
	            <when test="locale == 'ko'">
	                CASE
	                    WHEN INSTR(CN_KOR, '.', INSTR(CN_KOR, #{searchKeyword})) != 0 THEN
	                        SUBSTR(CN_KOR, INSTR(CN_KOR, #{searchKeyword}), INSTR(CN_KOR, '.', INSTR(CN_KOR, #{searchKeyword})) - INSTR(CN_KOR_TS, #{searchKeyword}) + 1)
	                    ELSE
	                        SUBSTR(CN_KOR, INSTR(CN_KOR, #{searchKeyword}), 50)
	                END AS CNKOR,
	                CASE
	                    WHEN MENU_NM_KOR_TS LIKE '%' || #{searchKeyword} || '%' THEN
	                        'Title'
	                    WHEN CN_KOR LIKE '%' || #{searchKeyword} || '%' THEN
	                        'Content'
	                    ELSE
	                        'None'
	                END AS SEARCHCATEGORY
	            </when>
	            <otherwise>
	                CASE
	                    WHEN INSTR(CN_ENG, '.', INSTR(CN_ENG, #{searchKeyword})) != 0 THEN
	                        SUBSTR(CN_ENG, INSTR(CN_ENG, #{searchKeyword}), INSTR(CN_ENG, '.', INSTR(CN_ENG, #{searchKeyword})) - INSTR(CN_ENG, #{searchKeyword}) + 1)
	                    ELSE
	                        SUBSTR(CN_ENG, INSTR(CN_ENG, #{searchKeyword}), 50)
	                END AS CNENG,
	                CASE
	                    WHEN MENU_NM_ENG_TS LIKE '%' || #{searchKeyword} || '%' THEN
	                        'Title'
	                    WHEN CN_ENG LIKE '%' || #{searchKeyword} || '%' THEN
	                        'Content'
	                    ELSE
	                        'None'
	                END AS SEARCHCATEGORY
	            </otherwise>
	        </choose>
	        FROM
	            KOAR_PRCUSE_GUIDE G
	        WHERE
	        	<if test="locale == 'ko'">
		        	(MENU_NM_KOR_TS LIKE '%' || #{searchKeyword} || '%'
			    			OR CN_KOR_TS LIKE '%' || #{searchKeyword} || '%')
	        	</if>
	        	<if test="locale == 'en'">
		        	(MENU_NM_ENG_TS LIKE '%' || #{searchKeyword} || '%'
			    			OR CN_ENG_TS LIKE '%' || #{searchKeyword} || '%')
	        	</if>
	            AND USE_AT = 'Y'
	</select>
