# carrot_market

단군 마켓 클론 코딩

## 메인 화면
### AppBar
- title
    - GestureDetector
        - Row
            - Text 
            - Icon 
- actions
    - IconButton 
    - SvgPicture

Appbar에는 title과 actions가 있음
title에는 1개의 Widget actions는 List<Widget>을 받음
title에 Column이나 Row를 넣어서 여러개를 받을 수도 정렬을 통해 가운데, 왼쪽, 오른쪽으로 놓을 수도 있다

### Body
- ListView
    - Container
        - Row: 1칸의 물건
            - ClipRRect: 물건 사진 둥글게
                - Image: 물건 사진
            - Container: 구분 용도
                - Column
                    - Text: 각 층별 물건, 주소, 가격
                    - SvgPicture: 좋아요
- SizedBox
- Expanded: 물건 설명 비율 설정

### BottomNavigation
- BottomNavigationBar
    -BottomNavigationBarItem
        -SvgPicture
        -Text 