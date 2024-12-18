create table if not exists category
(
    id         bigint auto_increment
        primary key,
    depth      int          not null,
    parent_id  bigint       null,
    name       varchar(255) not null,
    created_at datetime(6)  not null,
    updated_at datetime(6)  not null,
    constraint FK2y94svpmqttx80mshyny85wqr
        foreign key (parent_id) references category (id)
);

create table if not exists member
(
    id              bigint auto_increment
        primary key,
    name            varchar(255) not null,
    email           varchar(255) not null,
    password        varchar(255) not null,
    phone           varchar(255) not null,
    postal_code     varchar(255) not null,
    street_address  varchar(255) not null,
    detail_address  varchar(255) not null,
    refresh_token   varchar(255) null,
    last_login_date datetime(6)  null,
    created_at      datetime(6)  not null,
    updated_at      datetime(6)  not null,
    deleted_at      datetime(6)  null
);

create table if not exists orders
(
    id                    bigint auto_increment
        primary key,
    member_id             bigint                                                               not null,
    order_number          varchar(255)                                                         not null,
    orderer_name          varchar(255)                                                         not null,
    orderer_phone_number  varchar(255)                                                         not null,
    orderer_email         varchar(255)                                                         not null,
    recipient             varchar(255)                                                         not null,
    delivery_phone_number varchar(255)                                                         not null,
    postal_code           varchar(255)                                                         not null,
    street_address        varchar(255)                                                         not null,
    detail_address        varchar(255)                                                         not null,
    delivery_memo         varchar(255)                                                         null,
    discounted_price      decimal(38, 2)                                                       not null,
    price                 decimal(38, 2)                                                       not null,
    order_date            datetime(6)                                                          not null,
    payment_method        varchar(255)                                                         not null,
    payment_depositor     varchar(255)                                                         not null,
    status                enum ('COMPLETED', 'CANCELLED', 'SHIPPING', 'DELIVERED', 'REFUNDED') not null,
    created_at            datetime(6)                                                          not null,
    updated_at            datetime(6)                                                          not null,
    constraint orders_pk
        unique (order_number)
);

create table if not exists order_product
(
    id               bigint auto_increment
        primary key,
    discounted_price decimal(38, 2) not null,
    order_id         bigint         not null,
    price            decimal(38, 2) not null,
    product_id       bigint         not null,
    quantity         bigint         not null,
    created_at       datetime(6)    not null,
    updated_at       datetime(6)    not null,
    constraint FKl5mnj9n0di7k1v90yxnthkc73
        foreign key (order_id) references orders (id)
);

create table if not exists product
(
    id               bigint auto_increment
        primary key,
    author           varchar(255)                                                                   not null,
    category_id      bigint                                                                         null,
    title            varchar(255)                                                                   not null,
    description      text                                                                           not null,
    discounted_price decimal(38, 2)                                                                 not null,
    isbn             varchar(255)                                                                   not null,
    pages            int                                                                            not null,
    preview_link     varchar(255)                                                                   not null,
    price            decimal(38, 2)                                                                 not null,
    publisher        varchar(255)                                                                   not null,
    rating           double                                                                         not null,
    cover_image      varchar(255)                                                                   not null,
    status           enum ('CLOSE', 'ON_SALE', 'OUT_OF_STOCK', 'PROHIBITION', 'SUSPENSION', 'WAIT') not null,
    stock_quantity   int                                                                            not null,
    is_bestseller    bit                                                                            not null,
    is_hot_new       bit                                                                            not null,
    is_recommend     bit                                                                            not null,
    publish_date     date                                                                           null,
    created_at       datetime(6)                                                                    not null,
    updated_at       datetime(6)                                                                    null,
    deleted_at       datetime(6)                                                                    null
);

create table if not exists product_image
(
    id            bigint auto_increment
        primary key,
    display_order int          not null,
    image_url     varchar(255) not null,
    product_id    bigint       not null,
    constraint FK6oo0cvcdtb6qmwsga468uuukk
        foreign key (product_id) references product (id)
);

create table if not exists product_tag
(
    id         bigint auto_increment
        primary key,
    name       varchar(255) not null,
    product_id bigint       not null,
    created_at datetime(6)  not null,
    updated_at datetime(6)  not null
);

create table if not exists review
(
    id                       bigint auto_increment
        primary key,
    content                  text           not null,
    member_id                bigint         not null,
    product_id               bigint         not null,
    score                    decimal(38, 2) not null,
    order_product_id         varchar(255)   null,
    last_modified_by_user_at datetime       not null,
    created_at               datetime(6)    not null,
    updated_at               datetime(6)    not null
);

create table if not exists shopping_cart
(
    id         bigint auto_increment
        primary key,
    member_id  bigint      not null,
    product_id bigint      not null,
    quantity   int         not null,
    created_at datetime(6) not null,
    updated_at datetime(6) not null
);

INSERT INTO category (depth, parent_id, name, created_at, updated_at) VALUES (1, null, '국내도서', NOW(), NOW());
INSERT INTO category (depth, parent_id, name, created_at, updated_at) VALUES (1, null, '외국도서', NOW(), NOW());
INSERT INTO category (depth, parent_id, name, created_at, updated_at) VALUES (2, 1, '과학', NOW(), NOW());
INSERT INTO category (depth, parent_id, name, created_at, updated_at) VALUES (2, 2, '과학', NOW(), NOW());
INSERT INTO category (depth, parent_id, name, created_at, updated_at) VALUES (2, 1, '소설', NOW(), NOW());
INSERT INTO category (depth, parent_id, name, created_at, updated_at) VALUES (2, 2, '소설', NOW(), NOW());
INSERT INTO category (depth, parent_id, name, created_at, updated_at) VALUES (2, 1, '시', NOW(), NOW());
INSERT INTO category (depth, parent_id, name, created_at, updated_at) VALUES (2, 2, '시', NOW(), NOW());
INSERT INTO category (depth, parent_id, name, created_at, updated_at) VALUES (2, 1, '역사', NOW(), NOW());
INSERT INTO category (depth, parent_id, name, created_at, updated_at) VALUES (2, 2, '역사', NOW(), NOW());

INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('Rudolph Swift', 3, '[개발팀]국내도서 테스트 상품 (테스트 상품입니다.)', '‘국가란 무엇인가’ 이후, ‘역사란 무엇인가’를 묻다

유시민과 함께 역사의 갈피를 찾다!



『거꾸로 읽는 세계사』로부터 30년, 작가 유시민 글쓰기의 새로운 시작. 헤로도토스의 『역사』, 투키디데스의 『펠로폰네소스 전쟁사』부터 유발 하라리의 『사피엔스』까지 고대로부터 최근까지 역사를 사로잡은 18권의 역사서들을 9장으로 나누어 훑으며 ‘역사’라는 화두를 전개해간다. 각 역사서의 주요 내용과 시대적인 맥락, 서사의 새로운 초점과 해석, 역사가의 생애 등을 유시민만의 언어로 요약했다.



여기에 역사가의 속마음을 전달하고, 놓치지 말아야 할 부분을 체크해 주거나, 이해하지 못해도 좋다고 위로하고 격려하는 안내자 역할까지 맡았다. 역사에 대한 애정과 역사 공부의 중요성을 몸소 보여주며, 자신의 역사 공부법을 공개하는 셈이다.', 25317.00, '1111111111', 980, 'https://search.shopping.naver.com/book/catalog/49644215637', 29475.00, 'YES24', 3.9, 'https://shopping-phinf.pstatic.net/main_4964421/49644215637.20240806201630.jpg', 'ON_SALE', 90, false, true, false, '2024-08-06', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('Gose, Michael', 4, 'The Challenge of Greatness (The Legacy of Great Teachers)', 'The Challenge of Greatness:  The Legacy of Great Teachers reveals the characteristics and teaching strategies of Great Teachers.  Simultaneously the book describes a Pantheon of thirty-two great teachers, and challenges the reader to continue their legacy by becoming one.  Recognizing the uniqueness of a great teacher, the book raises the kind of issues they face, and a range of possibilities from which they find solutions.', 28778.00, '9781610480901', 140, 'https://search.shopping.naver.com/book/catalog/32474284194', 31672.00, '국내총판도서', 4.1, 'https://shopping-phinf.pstatic.net/main_3247428/32474284194.20220520074619.jpg', 'ON_SALE', 31, false, false, true, '2013-06-03', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('노영희', 5, '국내 의학도서관 사례집', '정보기술의 발달과 세계화, 개방화 등으로 우리 사회는 변화와 개혁을 요구하고 있다. 변화의 물결은 금융, 보험, 호텔, 정보, 통신 등의 영리 조직체뿐만 아니라 교육, 종교단체, 자선단체, 도서관 등과 같은 비영리 조직체에 있어서도 새로운 패러다임으로의 변화를 요구하고 있다. 의학은 특성상 학문의 변화속도가 매우 빠르고 신지식의 유입이 계속적으로 이루어짐에 따라 의학분야의 연구자들은 연구와 환자치료에 필요한 적절한 정보 습득이 무엇보다 필요한 상황에 직면하게 되었다. 이에 의료분야 도서관은 이러한 변화를 수용하는 제일선에 있다고 할 수 있으며, 특히 의학분야의 세분화, 유전공학 및 분자생물학의 진보 등으로 인하여 의학정보분야는 그 어느 때보다 전문적이고 심층적인 정보가 요구되고 있다. 의료분야 도서관(의학도서관, 병원도서관 등)은 보건, 의료분야에 종사하는 이용자를 대상으로 관련 연구, 교육 및 환자치료에 관계된 의학자료들을 수집, 정리, 축적하여 제공하는 기관이다. 의학분야 연구자들은 연구와 환자치료에 필요한 적절한 정보의 신속한 습득이 무엇보다 필요하며, 의료분야 도서관은 정보전달기관으로서 이러한 필요를 충족시키는 기능을 수행해야 한다.

그 중 의학도서관은 의과대학, 병원, 의료분야 연구소 등을 모기관으로 두며, 의학, 치과학, 간호학 및 약학과 같은 보건과학분야의 의사, 교수, 의과대학생, 간호사, 의료기사, 연구자 등에게 서비스를 제공하는 기관을 뜻한다. 의학도서관의 유형은 연구자에 따라 다양하게 구분되고 있으나, 국내에서는 한국의학도서관협회의 회원기관 분류를 따르는 것이 통상적이다. 구체적으로 한국의학도서관협회의 분류에 의하면, 소속기관이나 이용자의 성격 및 재정지원을 기준으로 의학도서관을 ① 의과대학, 의학전문대학원 및 보건의료분야의 교수와 학생을 위한 의과대학 및 보건대학도서관, ② 의료기관에 소속되어 모기관의 의료진을 위한 병원도서관, ③ 정부산하연구소를 지원하는 연구소도서관, ④ 제약회사처럼 의학과 관련된 산업체에 소속된 제약회사도서관 네 가지로 구분하고 있다.

이에 본서에서는 의료분야 관련 도서관들의 중요성과 역할 확대가 그 어느 때보다 중요한 시점에서 의료분야 도서관 중 가장 활발하게 운영되고 있는 의학도서관에 대해 알아보고자 한다. 본서는 의료분야 도서관을 위한 첫 사례집이라고 할 수 있다. 이 책을 통해 우리나라의 많은 도서관 연구자들이 의료분야 도서관을 조금 더 이해하는 계기가 되었으면 하는 바람이며, 향후 더 다양한 의료분야 도서관을 소개할 수 있기를 소망한다.', 24109.00, '9788959727315', 745, 'https://search.shopping.naver.com/book/catalog/32492770786', 28300.00, '청람', 1.8, 'https://shopping-phinf.pstatic.net/main_3249277/32492770786.20230530082504.jpg', 'SUSPENSION', 66, true, false, false, '2020-03-05', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('공병철 외 13명', 6, 'ISMS 보안인증 관리 (정보보안 부문 국내 최초 NCS 적용도서)', '『ISMS 보안인증 관리』는 국가직무능력표준(NCS, National Competency Standards) 직무수행능력 평가를 위해 구성된 도서이다. 이 책은 직무수행능력평가에 필요한 핵심 영역을 담은 도서로, 보안인증 관련 직무맥락에 기반하여 자세하게 설명함으로써 실전에서 다양하게 적용할 수 있도록 구성되어 있다.', 34768.00, '9788994567662', 388, 'https://search.shopping.naver.com/book/catalog/32506925110', 37561.00, '인포더북스', 4.8, 'https://shopping-phinf.pstatic.net/main_3250692/32506925110.20220527050648.jpg', 'OUT_OF_STOCK', 83, false, true, false, '2016-08-12', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('박미이^복혜원', 3, '빵 자매의  빵빵한 여행(국내 편)(큰글자도서) (빵이라면 죽고 못 사는 빵 자매의 국내여행)', '[큰글자도서]‘여행’으로 만나 ‘빵’으로 친해진
빵 자매의 아주 특별한 국내여행

≪빵 자매의 빵빵한 여행≫ 시리즈는 1편(유럽), 2편(아시아)에 이어 마지막 3편(국내)이 출간되었다. 빵이라면 죽고 못 사는 일명 빵 덕후인 빵 자매의 오로지 맛있는 빵을 찾아 떠나는 국내여행기를 소개한다. 국내 편을 기다렸을 독자들을 위해 모닝 빵, 간식 빵, 케이크, 디저트, 지역 명물 빵, 티타임 등 전국 빵집을 다채롭게 구성했다. 빵과 여행을 사랑하는 빵 자매가 엄선한 국내 빵집과 디저트 맛집뿐만 아니라 브런치, 커피, 애프터눈티 그리고 미처 담지 못한 빵 맛집까지 차곡차곡 담았다. 솔직 담백한 빵 이야기와 소소한 에피소드 그리고 유용한 팁까지 수록했다. 여행길에서 맛있는 빵을 만나는 즐거움을 한층 더 업그레이드하고 싶다면, ≪빵 자매의 빵빵한 여행(국내 편)≫으로 대리 포만감을 느껴 보자.', 32651.00, '9791168016323', 509, 'https://search.shopping.naver.com/book/catalog/34398306636', 36906.00, '이담북스', 4.9, 'https://shopping-phinf.pstatic.net/main_3439830/34398306636.20230725120727.jpg', 'CLOSE', 37, false, false, true, '2022-09-19', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('공병철', 5, '정보보안관제사 2급 (필기 / 실기 | 국내 최초 NCS 적용 민간자격 도서)', '차세대 정보보호 인재 양성을 위한 정보보안관제사!

실시간 정보 보안관제의 중요성과 필요성이 날로 증대되고 있는 지금, 기업에서는 보안관제 인력 수요가 계속적으로 증가하고 있다. 정보보안관제란 정보시스템에 가해지는 보안 위협을 24시간 365일 실시간으로 모니터링하여 악의적인 스캔 공격, 해킹 등 다양한 침해 공격을 탐지하고 다양한 정보보호 솔루션과 정보시스템에서 생성되는 로그를 분석하여 사이버 위협에 대응하는 것을 말한다.

정보보안관제사 자격증은 1, 2, 3급과 필기, 실기시험으로 나뉜다. 특히 정보보안관제사 2급 자격증 취득자는 ‘국가사이버안전관리규정에 따라 지정된 14개 보안관제 전문업체’ 등 보안관제 관련 업종에 취업 시, 공공기관과 기업의 정보보안 관련 실무담당자로 취업이 유리하다. 이 교재는 정보보안관제사 자격증 취득을 위한 표준 교재로서 각 분야별 보안 최고전문가가 참여하여 최신 보안관제 기술 경향분석을 통해 시험을 대비할 수 있도록 구성되어 있다.', 30320.00, '9788994567815', 615, 'https://search.shopping.naver.com/book/catalog/32467115656', 31397.00, '인포더북스', 4.8, 'https://shopping-phinf.pstatic.net/main_3246711/32467115656.20221228072547.jpg', 'ON_SALE', 87, true, false, false, '2018-01-19', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('송도수', 8, '수학도둑 83: 응용편 (MBC ’공부가 머니’ 수학 솔루션 도서, 국내 최초 수학논술만화)', '언제 어디에서나 원리를 응용하여 문제를 격파하는 수학의 해결사!

*TV 프로그램 교육 전문가 추천 수학교육서적!

MBC 〈공부가 머니?〉에 출연한 교육 컨설턴트가 수학 솔루션 도서로 〈수학도둑〉 시리즈를 추천!
인터넷 포털 사이트의 실시간 검색어 순위에 올라 학부모들과 어린이들 사이에서 화제가 되었습니다.

*믿을 수 있는 수학 전문가의 탄탄한 수학 콘텐츠!
수학 콘텐츠 저자 ㆍ 여운방 박사 프로필
서울대학교 공과대학 응용수학과 졸업, 미국 아이오와 주립대학 석사 및 박사. 한국개발연구원(KDI) 선임연구원, 교육부 멀티미디어 교육지원센터(KMEC) 소장, 대통령자문 정책기획위원회 위원, 한국교과서 연구재단 이사, 한국과학기술원(KAIST) 겸임교수 역임. 시스템수학연구회 회장.
〈수학도둑〉 〈창의사고력 수학퀴즈〉 〈메이플 매쓰〉의 수학 콘텐츠 집필.

*5단계 시스템 수학으로 수학 실력 쑥쑥쑥!
〈1단계 : 기본편〉 1~30권은 초·중등 교과과정을 종합하여 분류한 수와 연산, 도형, 측정, 확률과 통계, 규칙성, 문자와 식, 함수 등으로 구성되었고, 이를 바탕으로 개념이해력, 수리계산력, 원리응용력을 키울 수 있습니다.
〈2단계 : 심화편〉 31~45권은 실생활 속에 숨겨진 수학 개념 및 원리와 수학의 역사 속에 나타났던 심화된 내용으로 구성되었습니다. 또한 원리응용력을 키우고, 복잡하고 어려운 문제도 차근차근 풀 수 있는 문제해결방법이 자세히 설명되어 있습니다.
〈3단계 : 창의편〉 46~60권은 창의사고력을 강화시키고 수리논술의 기반을 튼튼히 하는 내용이 주축을 이룹니다. 이를 통해 수리논술의 기반을 튼튼하게 다지고, 비판적 사고를 포함한 의사소통력이 월등히 향상될 수 있습니다.
〈4단계 : 종합편〉 61~80권은 기본편, 심화편, 창의편을 아울러 개념ㆍ원리ㆍ법칙ㆍ해법을 명확히 종합 정리하는 주제들과 수학지도로 구성하였습니다. 이를 통해 영역별 ㆍ학년별로 종합 정리할 수 있습니다.
81권부터 시작되는 〈5단계 : 응용편〉은 1~4단계의 완결판으로, 생활 속, 역사 속, 타 교과 속에서 탄생되고 발전되었던 수학적 개념ㆍ원리와 흥미로운 이야기로 구성하였습니다. 언제 어디에서나 수학의 원리를 응용하여 어려운 문제를 해결할 수 있는 응용력을 키우는 데 도움이 될 것입니다.', 42011.00, '9791164384440', 192, 'https://search.shopping.naver.com/book/catalog/32481517719', 46698.00, '서울문화사', 3.9, 'https://shopping-phinf.pstatic.net/main_3248151/32481517719.20230711114331.jpg', 'SUSPENSION', 37, false, true, false, '2021-07-20', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('송도수', 3, '수학도둑 82: 응용편 (MBC ’공부가 머니’ 수학 솔루션 도서, 국내 최초 수학논술만화)', '언제 어디에서나 원리를 응용하여 문제를 격파하는 수학의 해결사!

*TV 프로그램 교육 전문가 추천 수학교육서적!
MBC 〈공부가 머니?〉에 출연한 교육 컨설턴트가 수학 솔루션 도서로 〈수학도둑〉 시리즈를 추천!
인터넷 포털 사이트의 실시간 검색어 순위에 올라 학부모들과 어린이들 사이에서 화제가 되었습니다.

*믿을 수 있는 수학 전문가의 탄탄한 수학 콘텐츠!
수학 콘텐츠 저자 ㆍ 여운방 박사 프로필
서울대학교 공과대학 응용수학과 졸업, 미국 아이오와 주립대학 석사 및 박사. 한국개발연구원(KDI) 선임연구원, 교육부 멀티미디어 교육지원센터(KMEC) 소장, 대통령자문 정책기획위원회 위원, 한국교과서 연구재단 이사, 한국과학기술원(KAIST) 겸임교수 역임. 시스템수학연구회 회장.
〈수학도둑〉 〈창의사고력 수학퀴즈〉 〈메이플 매쓰〉의 수학 콘텐츠 집필.

*5단계 시스템 수학으로 수학 실력 쑥쑥쑥!
〈1단계 : 기본편〉 1~30권은 초·중등 교과과정을 종합하여 분류한 수와 연산, 도형, 측정, 확률과 통계, 규칙성, 문자와 식, 함수 등으로 구성되었고, 이를 바탕으로 개념이해력, 수리계산력, 원리응용력을 키울 수 있습니다.
〈2단계 : 심화편〉 31~45권은 실생활 속에 숨겨진 수학 개념 및 원리와 수학의 역사 속에 나타났던 심화된 내용으로 구성되었습니다. 또한 원리응용력을 키우고, 복잡하고 어려운 문제도 차근차근 풀 수 있는 문제해결방법이 자세히 설명되어 있습니다.
〈3단계 : 창의편〉 46~60권은 창의사고력을 강화시키고 수리논술의 기반을 튼튼히 하는 내용이 주축을 이룹니다. 이를 통해 수리논술의 기반을 튼튼하게 다지고, 비판적 사고를 포함한 의사소통력이 월등히 향상될 수 있습니다.
〈4단계 : 종합편〉 61~80권은 기본편, 심화편, 창의편을 아울러 개념ㆍ원리ㆍ법칙ㆍ해법을 명확히 종합 정리하는 주제들과 수학지도로 구성하였습니다. 이를 통해 영역별 ㆍ학년별로 종합 정리할 수 있습니다.
81권부터 시작되는 〈5단계 : 응용편〉은 1~4단계의 완결판으로, 생활 속, 역사 속, 타 교과 속에서 탄생되고 발전되었던 수학적 개념ㆍ원리와 흥미로운 이야기로 구성하였습니다. 언제 어디에서나 수학의 원리를 응용하여 어려운 문제를 해결할 수 있는 응용력을 키우는 데 도움이 될 것입니다.', 17549.00, '9791164384006', 249, 'https://search.shopping.naver.com/book/catalog/32441645832', 19826.00, '서울문화사', 4.3, 'https://shopping-phinf.pstatic.net/main_3244164/32441645832.20230711114607.jpg', 'SUSPENSION', 85, false, false, true, '2021-05-20', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('공병철^여동균^오원철^김형구^이원연', 5, '정보보안관제사 실전 기출문제집(2018) (1ㆍ2ㆍ3급 필기 / 실기 | 국내 최초 NCS 적용 민간자격 도서)', '"차세대 정보보호 인재 양성을 위한 정보보안관제사!

실시간 정보 보안관제의 중요성과 필요성이 날로 증대되고 있는 지금, 기업에서는 보안관제 인력 수요가 계속적으로 증가하고 있다. 정보보안관제란 정보시스템에 가해지는 보안 위협을 24시간 365일 실시간으로 모니터링하여 악의적인 스캔 공격, 해킹 등 다양한 침해 공격을 탐지하고 다양한 정보보호 솔루션과 정보시스템에서 생성되는 로그를 분석하여 사이버 위협에 대응하는 것을 말한다.
정보보안관제사 자격증은 1, 2, 3급과 필기, 실기시험으로 나뉜다. 특히 정보보안관제사 2급 자격증 취득자는 ‘국가사이버안전관리규정에 따라 지정된 14개 보안관제 전문업체’ 등 보안관제 관련 업종에 취업 시, 공공기관과 기업의 정보보안 관련 실무담당자로 취업이 유리하다.
이 교재는 정보보안관제사 자격증 취득을 위한 표준 교재로서 각 분야별 보안 최고전문가가 참여하여 최신 보안관제 기술 경향분석을 통해 시험을 대비할 수 있도록 구성되어 있다. 특히 각 과목별 예상 문제와 실전 문제를 수록하여 수험생의 합격률을 높이는 데에 도움을 준다. 이 책에 수록된 실전 문제는 필기와 실기 시험 모두를 대비할 수 있으며, 실기 문제의 경우 각 유형별 문제와 해설을 수록하여 문제와 이론을 한 번에 익힐 수 있다.
"', 29552.00, '9788994567839', 909, 'https://search.shopping.naver.com/book/catalog/32493230744', 34375.00, '인포더북스', 4.1, 'https://shopping-phinf.pstatic.net/main_3249323/32493230744.20230718121939.jpg', 'SUSPENSION', 71, true, false, false, '2018-02-14', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('청소년행복연구실', 3, '나의 직업 군인(공군) (하나의 직업을 1권의 책에 담은 국내 최초 직업 전문 도서)', '『나의 직업 군인(공군)』에서는 우리나라의 공군이 어떻게 생겨났으며, 무슨 일을 하고 어떤 대우를 받는지, 또 공군이 되는 방법에는 어떠한 것들이 있는지 등을 상세히 다루고 있다.', 46379.00, '9791185488264', 920, 'https://search.shopping.naver.com/book/catalog/32497549635', 48190.00, '동천출판', 3.3, 'https://shopping-phinf.pstatic.net/main_3249754/32497549635.20220527035305.jpg', 'SUSPENSION', 82, false, true, false, '2014-09-05', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('하영훈', 10, '구글 스마트워치 프로그래밍 - 안드로이드 웨어 활용 (안드로이드 웨어 활용 | 국내 최초 스마트워치 프로그래밍 도서)', '구글 스마트워치 프로그래밍의 기본 입문서. 이 책은 스마트워치와 웨어러블 컴퓨터에 맞게 만들어진 운영체제인 안드로이드 웨어의 활용 방법을 알려준다. IoT가 범용화되면서 모토360, 갤럭시기어, G워치와 함께 스마트워치가 사람들의 일상으로 파고들고 있는 이 시점에, 안드로이드 개발자들은 이 책을 통해서 안드로이드 웨어 프로그래밍의 기본 원리와 활용법을 익힐 수 있다. 저자가 운영하는 카페에 가면 소스와 다양한 자료가 있으며, 궁금 사항을 올리면 자세한 답변을 받을 수 있다.', 24769.00, '9788994797144', 836, 'https://search.shopping.naver.com/book/catalog/32460079242', 28202.00, '비팬북스', 1.2, 'https://shopping-phinf.pstatic.net/main_3246007/32460079242.20221230071916.jpg', 'SUSPENSION', 74, false, false, true, '2014-10-08', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('권민조', 7, '할머니의 용궁 여행 (2021 경남독서한마당 선정도서, 2021 국가인권위원회 인권도서관 어린이인권도서 목록 추천도서, 2021 읽어주기좋은책 선정도서, 2020 문학나눔 선정도서)', '아윤이의 할머니는 경상도 바닷가 마을의 해녀예요. 할머니가 물질하러 바다로 나가면 아윤이는 집에서 할머니를 기다리지요. 그러던 어느 날, 할머니가 늦게까지 돌아오지 않자 아윤이는 할머니가 걱정되어 바닷가로 갑니다. 막 뭍으로 나온 할머니는 바닷속에서 엄청난 일을 겪었다며 재미난 이야기를 들려주었지요. 평소처럼 미역 밭 가꾸러 바다로 들어간 할머니는 엄청 큰 전복이 무더기로 있는 걸 발견하고망사리 째로 쓸어 담고 있었지요. 그때 할머니 앞에 넓적한 광어가 나타나서는 자기 좀 살려 달라고 애원했어요. 평소 어려운 사람을 모른척하지 않는 할머니는 광어를 도와주겠다고 해요. 광어가 할머니 주위를 뱅뱅 돌자 할머니는 납작해지고 아가미도 생기더니 바위틈으로 들어가게 되지요. 물이 뜨끈했다가 차가웠다가 늘어났다 줄어들었다 백여덟 번 될 때쯤 지나자, 할머니는 으리으리한 용궁에 도착해요. 그런데 들어가자마자 바다 동물들이 할머니 무릎을 꿇리더니 용왕인 거북이 아프다며 할머니에게 간을 달라는 거예요. 무슨 소리를 하냐며 불같이 화를 내던 할머니는 용왕 거북의 얼굴을 보고 너무 불쌍해서 할말을 잃어요. 도대체 바다동물들에게 무슨 일이 일어난 걸까요? 할머니는 이 위기를 넘기고 무사히 집으로 돌아올 수 있을까요?', 10550.00, '9791190077439', 409, 'https://search.shopping.naver.com/book/catalog/32436150983', 12943.00, '천개의바람', 3.5, 'https://shopping-phinf.pstatic.net/main_3243615/32436150983.20230927071400.jpg', 'ON_SALE', 83, true, false, false, '2020-04-07', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('별다름^달다름', 8, '브로콜리지만 사랑받고 싶어 (초등 1학년 국어교과서 수록 도서)', '♣ 초등 1학년 2학기 국정 국어 교과 나권 수록 ♣

사랑받는 채소가 되긴 위한
브로콜리의 엉뚱 발랄 대작전!

아이들이 싫어하는 채소 1위에 뽑힌 브로콜리는 사랑받는 채소가 되기 위한 계획을 세워요. 바로 사랑받는 친구들을 모두 따라해 보는 거죠. 소시지를 따라 분홍색으로 화장도 해 보고, 라면처럼 뽀글뽀글 파마도 해 봅니다. 오이가 인터넷 방송으로 인기를 얻었다는 이야기를 듣자 자신만만하게 오이를 따라 인터넷 방송도 해 보지요. 그런데 왜 아무 소용도 없을까요? 브로콜리지만 사랑받을 수 있을까요?', 17119.00, '9791157855506', 879, 'https://search.shopping.naver.com/book/catalog/32473886750', 21171.00, '키다리', 2.8, 'https://shopping-phinf.pstatic.net/main_3247388/32473886750.20230411163902.jpg', 'SUSPENSION', 59, false, true, false, '2021-12-13', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('조명화', 8, '여행도서 콘텐츠에 반영된 원샷 여행트렌드 2015 : 여행도서 트렌드에 관한 국내 최초 석사논문', '-', 28031.00, '9791185778730', 110, 'https://search.shopping.naver.com/book/catalog/43289320624', 31274.00, '테마여행신문 TTN Theme Travel News Korea', 1.1, 'https://shopping-phinf.pstatic.net/noimage/noimage.jpg', 'OUT_OF_STOCK', 19, false, false, true, '2015-02-02', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('Heather Nitzsche', 10, 'NEW EQ(이큐)의 천재들 (전115종) / 세이펜 미포함', '', 46244.00, '9791186922132', 529, 'https://search.shopping.naver.com/book/catalog/45208473621', 47333.00, '도서출판무지개(전집)', 1.5, 'https://shopping-phinf.pstatic.net/main_4520847/45208473621.20240112124818.jpg', 'WAIT', 71, true, false, false, '2023-12-26', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김민성', 6, '엄마 닭이 꼬꼬 (새 유치원 교육과정 주제별 교재, 서울유아언어교육연구회, 한국국공립유치원연합회 추천도서)', '‘봄’ 주제를 왜 가르쳐야 할까요?
우리나라는 기온의 변화에 따른 사계절의 흐름 속에서
생활하게 되므로 계절은 유아가 살아가는 시·공간적
배경이 됩니다. 계절의 변화에 따라 자연과 날씨,
우리들의 생활 모습 등이 자연히 달라지므로 계절에 대한
충분한 이해는 유아들의 건강한 일상생활을 위해서도
직접적인 도움이 됩니다.', 16700.00, '9788963830582', 683, 'https://search.shopping.naver.com/book/catalog/41172641619', 20838.00, '아람출판사', 1.3, 'https://shopping-phinf.pstatic.net/main_4117264/41172641619.20230725120254.jpg', 'CLOSE', 46, false, true, false, '2023-07-01', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('하이진', 10, '4번 달걀의 비밀 (2024 경남독서한마당 선정 도서)', '『야광 시계의 비밀』로 건강하게 일할 수 있는 권리에 대해 생각해보게 했던 하이진 작가의 신작

제7회 상상만발책그림전 당선작.
평생 작은 집에서 함께 살아온 세 마리 닭, 어느 날 문득 자신들이 낳은 달걀은 왜 모두 4번이라고 적혀 있는지 궁금해합니다. 그때 낯선 닭이 찾아와 4번 달걀의 비밀을 알려 주려다 누군가에게 잡혀갑니다. 도대체 4번 달걀의 비밀은 무엇일까요?

*심사평
4번 달걀의 비밀을 알고 계시나요? 하이진 작가의 『4번 달걀의 비밀』은 매력적인 캐릭터와 유쾌한 코미디로 우리에게 불편한 진실을 일깨워주는, 아주 특별한 작품입니다!
_이루리(작가/세종사이버대학교 문예창작학과 교수)', 41359.00, '9791165883157', 472, 'https://search.shopping.naver.com/book/catalog/40827382638', 43425.00, '북극곰', 4.1, 'https://shopping-phinf.pstatic.net/main_4082738/40827382638.20230626202022.jpg', 'SUSPENSION', 65, false, false, true, '2023-07-10', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('신정일', 9, '여행자를 위한 도시 인문학: 전주·완주(큰글자도서) (여행자를 위한 도시 인문학)', '“솔찬히 예쁘네” “그렁게”
둘이면서 하나인 땅, 전주-완주에서 역사 속 문화와 풍류를 만나는 시간

속 깊은 도시여행자를 위한 전주·완주 인문여행 안내서. 오랜 역사와 전통 속에 문화와 풍류가 흐르고 그 어느 지역보다 독특한 개성을 지닌 도시가 전주다. 조선을 건국한 태조 이성계의 조상이 살았다고 해서 객사의 이름조차 풍패지관(豊沛之館)이라고 붙인 전주는 동학농민군이 무혈입성을 한 뒤 전주화약을 맺었던 역사의 현장이기도 하다. 전라북도의 한복판에서 전주시를 감싸 안고 있는 완주군은 전주와 한몸처럼 역사와 자연을 공유하고 이름난 산과 절이 유독 많다. 100여 권의 책을 집필하는 동안 인생의 희망과 절망이 그물코처럼 촘촘히 짜여 있는 전주와 완주에 대한 저서를 훗날의 숙제로 남겨놓았던 저자는 이 책에서 도시의 시간 속에 아로새겨진 자신의 이야기를 시처럼 자연스럽게 엮어냈다. 그야말로 전주ㆍ완주로 떠나는 여행자를 위한 맞춤형 도시 인문학서다.', 37962.00, '9791193810019', 566, 'https://search.shopping.naver.com/book/catalog/47164550621', 41650.00, '가지', 3.2, 'https://shopping-phinf.pstatic.net/main_4716455/47164550621.20240501071201.jpg', 'OUT_OF_STOCK', 89, true, false, false, '2024-04-20', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('생각연필', 8, '슈~웅! 하늘을 나는 비행기 (세이펜 적용)', '하늘을 나는 비행기의 종류와 기능, 특징 이해

하늘을 나는 비행기는 승객을 실어 나르는 여객기와 화물을 실어 나르는 화물기 등
민간에서 사용하는 비행기와 우리나라의 하늘을 지키기 위한 전투기 F-15, F-16
지상 목표물을 공격하기 위한 공격기 A-10, 공중에서 적의 영상 및 신호 정보 등을
정찰하기 위한 정찰기 U2 등 군에서 사용하는 군용비행기가 있어요.
슈~웅! 하늘을 나는 비행기는 비행기의 종류와 기능, 특징 등을 알고 비행기 중 우리가
흔히 볼 수 있는 민간 여객기를 이용하는 방법 등을 유아가 쉽게 이해할 수 있도록 해줍니다.', 39697.00, '9788967613051', 742, 'https://search.shopping.naver.com/book/catalog/42917872627', 43411.00, '도서출판대원', 1, 'https://shopping-phinf.pstatic.net/main_4291787/42917872627.20230929071048.jpg', 'WAIT', 33, false, true, false, '2023-10-01', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('조시온', 8, '새빨간 질투 (2023 세종도서 교양부문)', '조시온 X 이소영 작가의 유쾌 발랄한 감정 그림책

마음속에 활활 불타오르는
새빨간 질투를 슬기롭게 다스리는 방법!

<b>원하는 걸 지울 수 있다고?!
질투에 사로잡힌 말썽꾸러기 빨강의 이야기</b>
백설공주에게 독이 든 사과를 먹인 사악한 왕비, 제비의 멀쩡한 다리를 부러뜨린 욕심쟁이 놀부, 수단과 방법을 가리지 않고 왕위를 차지하려 했던 라이온 킹의 스카, 흔히 우리가 악당이라 부르는 이 인물들의 공통점은 무엇일까요? 바로 이야기 속 주인공을 시기하고 질투하며 못된 일을 꾸미다가 결국 벌을 받게 되었다는 거예요. 이처럼 질투심은 악당의 자질 중 가장 기본이라 할 수 있어요. 그리고 이 이야기 속에서도 질투에 사로잡혀 말썽을 일으키는 인물이 있죠. 《새빨간 질투》의 주인공 ‘빨강’이에요.
추운 겨울날 빨간 장갑, 빨간 목도리, 빨간 전구, 빨간 트리 장식까지 거리 곳곳은 온통 빨강으로 가득했어요. 빨강은 자신이 최고의 스타가 된 것 같아 무척 기뻤죠. 하지만 기쁨도 잠시, 뉴스에서 앞으로 유행할 색이 파랑이라는 충격적인 소식이 전해져요. 빨강은 절대 그럴 리 없다고 애써 부정했지만, 날이 따뜻해질수록 파랑이 점점 빨강의 자리를 넘보았죠. 빨강은 그런 파랑이 눈에 거슬렸어요. 몰래몰래 파랑의 흉을 보기도 했고, 급기야 참을 수 없는 분노가 폭발하며 파랑이 사라졌으면 좋겠다고 외쳤죠. 그러자 빨강의 귓가로 어디선가 희미한 소리가 들려왔어요. “원하는 걸 지울 수 있어!” 빨강은 새빨간 지우개를 집어 들고서 슬며시 음흉하고 고약한 미소를 지었어요. 여느 악당처럼요.

<b>질투를 통해 발견하는 내면의 목소리
내가 진짜 원하는 게 무엇인지 귀 기울여 보세요!</b>
빨강은 새빨간 지우개를 들고 거리로 나섰어요. 파랑을 모조리 쓱쓱 지우며 이리저리 바쁘게 돌아다녔죠. 빨강이 다녀간 자리는 금세 후덥지근한 공기로 뒤바뀌었어요. 빨강이 신이 나 쏘다닐수록 사람들은 더위를 피해 파랑 곁으로 모여들었죠. 그런데 빨강의 예상과 달리 파랑은 지워도 지워도 끝이 보이지 않았어요. 게다가 빨강을 향한 사람들의 불만이 점점 커져만 갔고, 빨강은 자신을 비난하는 목소리에 둘러싸이는 악몽까지 꾸게 되었어요. 어느새 빛바래진 자기 모습을 보며 이대로 영영 사라지게 되는 건 아닐까 하는 두려움에 울컥 눈물이 솟았죠. 과연 빨강은 그토록 바라던 인기를 되찾고 예전의 기쁨을 다시 누릴 수 있을까요?
《새빨간 질투》 속 빨강을 보다 보면 질투라는 감정이 무시무시하게 느껴지지 않나요? 빨강은 파랑을 질투한다는 사실을 받아들이지 못하고, 무작정 파랑을 없애야겠다는 어리석은 생각에 빠졌어요. 그러나 정작 빛을 잃고 사라져 가는 건 빨강, 자기 자신이었죠. 우리 주변에도 빨강과 같은 친구들이 많아요. 주위에 ‘더’ 잘난 사람들과 자신을 끊임없이 비교하며 스스로를 불행에 빠뜨리죠. 하지만 주위에 부러운 사람이 많다는 건 결코 나쁜 일이 아니에요. 질투라는 감정을 외면하지 않고 내면의 목소리에 귀를 기울인다면 말이죠. 질투를 통해 자신이 진짜 원하는 게 무엇인지, 무엇을 그토록 부러워했는지를 차분히 들여다보는 거예요. 그러다 보면 긍정적인 삶의 자극도 얻고, 따라 배우고자 하는 동기 부여가 될 수도 있어요.

<b>조시온 작가와 이소영 작가의 협업으로 탄생한 《새빨간 질투》
유쾌 발랄한 이야기 속에서 마주하게 된 진심!</b>
노란상상 그림책 아흔아홉 번째 이야기 《새빨간 질투》는 조시온 작가가 글을 쓰고, 이소영 작가가 그림을 그렸어요. 처음 호흡을 맞췄던 《마음안경점》에 이어 두 번째로 함께 작업한 그림책이자 두 작가의 한층 더 업그레이된 케미가 빛을 발하는 작품이죠. 조시온 작가는 독자들과 함께 질투를 건강하고 슬기롭게 다스리는 방법에 대해 고민해 보고 싶었다고 해요. 계절의 변화에 따라 빨강의 심리 변화를 그려 내며, 부정적인 감정으로 치부되는 질투를 누구나 공감할 수 있는 재미난 이야기로 풀어냈어요. 여기에 이소영 작가가 빨강, 파랑, 검정 세 가지 색을 활용해 이야기를 더 입체적으로 구현해 냈죠. 무엇보다 화면 안에서 빨강과 파랑이 엎치락뒤치락하는 모습들이 이야기의 몰입과 흥미를 더욱 북돋아 줄 거예요.
질투는 누구에게나 찾아오는 자연스러운 감정이에요. 어린아이든 어른이든 상관없이 공평하게요. 하지만 우리는 여전히 질투를 느낄 때면 그 감정을 꼭꼭 숨기고 꾹꾹 억누르려고 해요. 그럴수록 질투는 미움, 분노, 원망과 함께 더 커져만 갈 뿐인데 말이죠. 《새빨간 질투》를 통해 그동안 외면하고 부정해 왔던 마음들을 하나둘 꺼내 보며, 질투를 온전하게 마주하는 용기를 가져 보면 어떨까요? 질투의 힘을 성장의 원동력으로 슬기롭게 전환하는 방법에 대해서도 곰곰이 생각해 볼 수 있어요.

〈font color=orange〉★〈/font〉교과 연계〈font color=orange〉★〈/font〉
누리과정 사회관계 영역 : 나와 다른 사람의 감정 알고 조절하기
국어 1-1 7. 생각을 나타내요
국어 2-1 3. 마음을 나누어요
국어 2-2  8. 마음을 짐작해요', 30807.00, '9791191667899', 443, 'https://search.shopping.naver.com/book/catalog/39858897621', 33141.00, '노란상상', 4.2, 'https://shopping-phinf.pstatic.net/main_3985889/39858897621.20230704090805.jpg', 'ON_SALE', 71, false, false, true, '2023-05-25', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김슬기', 6, '모모와 토토 하트하트(빅북) (2023 북스타트 선정도서)', '그림책 《모모와 토토 하트하트》가 빅북으로 나왔어요!
기존 판형보다 171%나 커져 더 넓은 화면으로
모모와 토토의 우정을 지켜볼 수 있습니다.
실로 단단하게 제본하여 찢어질 염려도 없지요!
더 커다란 책으로 《모모와 토토 하트하트》를 만나 보세요.

모모와 토토
토토에게는 좋아하는 친구가 있어요. 바로 모모랍니다. 토토는 정성스럽게 그린 하트를 모모에게 주어요. 모모는 하트가 너무 좋았어요. 모모는 토토에게 하트를 많이 달라고 졸랐어요. 모모는 토토에게 받은 하트로 집 전체를 멋지게 꾸몄어요. 하트로 가득한 집을 친구들이 구경을 왔지요. 모모는 점점 더 하트를 많이 받고 싶고, 많은 하트는 모모를 우쭐하게 만들었어요. 그런데 언젠가부터 토토는 놀러 오지 않았어요. 토토에게 무슨 일이 생긴 걸까요? 모모는 토토의 집에 찾아가 보았지만 토토는 혼자 책을 보고, 피아노를 치고, 장난감을 갖고 놀면서 모모에게 더 이상 하트를 그려주지 않았어요. 토토랑 놀 수 없는 모모는 너무 심심해졌어요. 집으로 돌아온 모모는 곰곰이 생각하게 되었어요. 모모와 토토에게 하트는 무슨 의미일까요?', 27534.00, '9788943315870', 643, 'https://search.shopping.naver.com/book/catalog/44031562628', 28881.00, '보림', 3.6, 'https://shopping-phinf.pstatic.net/main_4403156/44031562628.20231119070924.jpg', 'ON_SALE', 53, true, false, false, '2023-06-26', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김유', 4, '사자마트 (2024 경남독서한마당 추천도서)', '바람그림책 137권. 김유 작가와 소복이 작가가 다시 뭉친 두 번째 그림책입니다. 아파트 상가에 사자 씨가 ‘사자마트’를 열었습니다. 사자 씨의 이름이면서, 사람들이 물건을 많이 사러 오길 바라는 마음을 담은 마트였지요. 한 아주머니가 사자마트에 들어섰습니다. 사자 씨가 인사를 했는데, 아주머니가 보고 화들짝 놀라더니 뒤돌아 나가버렸습니다. 그 뒤로 동네 사람들은 사자마트에 대해 수군댔습니다. “성격이 고약해 보이던데요.”, “꼭 사자 같더라고요.” 어느새 물건을 사자가 아닌, 무서운 사자가 있는 곳이 되어 버린 사자마트. 과연 사자 씨의 ‘사자마트’는 어떻게 될까요?', 20004.00, '9791165734091', 674, 'https://search.shopping.naver.com/book/catalog/38966281618', 23871.00, '천개의바람', 4, 'https://shopping-phinf.pstatic.net/main_3896628/38966281618.20230927071328.jpg', 'PROHIBITION', 28, false, true, false, '2023-03-28', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('최혜영', 4, '누나는 봄이 보여? (새 유치원 교육과정 주제별 교재, 서울유아언어교육연구회, 한국국공립유치원연합회 추천도서)', '‘봄’ 주제를 왜 가르쳐야 할까요?
우리나라는 기온의 변화에 따른 사계절의 흐름 속에서
생활하게 되므로 계절은 유아가 살아가는 시·공간적
배경이 됩니다. 계절의 변화에 따라 자연과 날씨,
우리들의 생활 모습 등이 자연히 달라지므로 계절에 대한
충분한 이해는 유아들의 건강한 일상생활을 위해서도
직접적인 도움이 됩니다.', 12047.00, '9788963830933', 704, 'https://search.shopping.naver.com/book/catalog/41172661621', 13836.00, '아람출판사', 2.7, 'https://shopping-phinf.pstatic.net/main_4117266/41172661621.20230725120924.jpg', 'ON_SALE', 57, false, false, true, '2023-07-01', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('그림말', 8, '나랑 우산 같이 쓸래? (새 유치원 교육과정 주제별 교재, 서울유아언어교육연구회, 한국국공립유치원연합회 추천도서)', '‘봄’ 주제를 왜 가르쳐야 할까요?
우리나라는 기온의 변화에 따른 사계절의 흐름 속에서
생활하게 되므로 계절은 유아가 살아가는 시·공간적
배경이 됩니다. 계절의 변화에 따라 자연과 날씨,
우리들의 생활 모습 등이 자연히 달라지므로 계절에 대한
충분한 이해는 유아들의 건강한 일상생활을 위해서도
직접적인 도움이 됩니다.', 29914.00, '9788963830742', 451, 'https://search.shopping.naver.com/book/catalog/41172640618', 34659.00, '아람출판사', 1.1, 'https://shopping-phinf.pstatic.net/main_4117264/41172640618.20230725121026.jpg', 'SUSPENSION', 59, true, false, false, '2023-07-01', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('문승주^김일', 7, '지적전산·토지정보체계론 (국가기술자격 출제기준과 동일한 구성 국내 유일 체계적인 토지정보체계 이론서)', '우리는 흔히 정보의 홍수 속에 산다고 표현한다. 컴퓨터가 개발되고, 인터넷을 이용하면서 수많은 정보가 넘쳐나고 있으며, 지금 이 순간에도 어마어마한 양의 정보가 생성되고 있다. 이 수많은 정보가 모두 활용가치와 정확성이 높고, 지속적으로 활용된다고는 볼 수 없지만 그중에서도 인간생활에 꼭 필요한 정보들이 있다. 특히 인간은 하루라도 토지를 밟지 않고 살 수 없기 때문에 토지와 관련된 정보는 다른 정보에 비해 그 중요성이 무척 크다고 할 수 있다. 토지정보는 인간생활에 없어서는 안 되는 기본 인프라로서 토지정책, 거래, 과세, 평가 등 여러 분야에서 활용되고 있다.
토지정보는 인류가 집단생활을 하면서부터 만들어져 종이의 기록이나 도면의 형태 등으로 관리되고 활용되었다. 여기에 전산화와 전자정부의 구현을 통해 다양한 분야의 활용을 위해 토지정보체계가 구축되었고, 현재 토지정보시스템이 운영되고 있다. 이 시스템의 효과적인 운영을 위해 GIS라는 Tool을 사용하는데, 이는 지리정보시스템이나 도시정보시스템 등에 다양하게 활용되고 있어 간혹 지리정보시스템의 일부분으로 인식되기도 한다. 가령 컴퓨터를 이용하여 문서를 작성하거나 음악작곡 작업을 할 수 있는데, 컴퓨터를 사용한다고 해서 두 개의 작업을 동일하다고 판단하지는 않을 것이다. 우리가 컴퓨터를 하나의 도구로 보듯 GIS S/W도 동일한 도구일 뿐이며, 어떠한 목적으로 데이터를 구축하고, 활용되는지가 더욱 중요할 것이다.
토지라는 것은 인간이 영유하는 모든 것의 기반이며, 이러한 토지를 관리하는 법적, 행정적속성정보와 위치 및 범위를 나타내는 도형정보 등으로 구성된 토지정보체계는 국가의 행정뿐만 아니라 국민 개개인에 있어서도 토지의 거래 등 다양한 분야에서 중요한 정보로 작용할 수밖에 없다. 이것이 바로 지리정보시스템과의 큰 차별성을 갖는 것으로 토지정보를 수집, 구축, 분석, 활용하는 전 과정 자체로도 특별하게 취급된다. 즉, 국가가 중요한 자산으로서 관리하는 정보로서의 중요함과 특별함, 그리고 개인의 사유재산을 정보화하여 관리하는 의미가 있는 것이다. 따라서 토지정보체계의 중요성을 인식하여 학문 체계를 만들고, 체계적인 지적기술자 양성을 위해 국가기술자격 과목과 세부항목 등 체계를 수립했으나 전문서적이 거의 없으며, 존재하여도 오래 되었거나 지적전산화 부분만을 다루는 경우가 많아 토지정보체계 전반에 걸친 이론서에 대한 강력한 요구가 있어 중앙부처, 학계, 산업계 근무경험을 살려 본서를 저술하게 되었다.
1980년대 이후 Dale, Mclaughlin, Williamson 등 저명한 외국 교수들의 많은 연구가 있었고, 어려운 환경에서도 김영학, 이성화, 지종덕 교수님 등 여러 학자들의 꾸준한 연구가 본서 기술에 많은 도움이 되었다. 또한 유환종, 서용수, 곽인선, 이효상 교수님 등 주변의 많은 분들의 도움이 있었기에 오늘 체계적으로 정리된 토지정보체계론을 출간할 수 있었으므로 큰 기쁨과 감사의 인사를 드린다. 본서를 통해 후학들이 더 많은 지식을 함양하기를 바라며, 이것이 끝이 아니라 새로운 학문의 지경을 넓히는 출발점이 되기를 기대한다.', 32109.00, '9788927452720', 284, 'https://search.shopping.naver.com/book/catalog/44589047629', 35675.00, '예문사', 1.4, 'https://shopping-phinf.pstatic.net/main_4458904/44589047629.20231212091300.jpg', 'ON_SALE', 69, false, true, false, '2024-01-10', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('안도현', 7, '꽃밭에서', '안도현 시인의 동시그림책 시리즈 『꽃밭에서』. 아이들에게 순수하고 아름다운 동시를 들려주세요! 사랑스럽고 귀여운 우리 아이에게 어떤 글자를 보여줄까요? 이 동시그림책 시리즈는 그런 고민을 해결해줍니다. 쉽게 따라할 수 있는 언어, 책과 친해질 수 있는 그림. 아이가 안도현 시인의 동시로 글자를 배울 수 있도록 읽어주세요!', 17521.00, '9788967610678', 749, 'https://search.shopping.naver.com/book/catalog/33435599796', 21866.00, '도서출판대원', 5, 'https://shopping-phinf.pstatic.net/main_3343559/33435599796.20240418070938.jpg', 'WAIT', 84, false, false, true, '2023-03-05', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김선희', 4, '전기를 먹어요 (세이펜 적용, 세이펜 미포함, 한국국공립유치원교원연합회 추천도서)', '학교 안전 교육 7대 표준안 7개 영역에 맞춘 삐뽀삐뽀 안전동화 !!

『삐뽀삐뽀 안전동화』는 \'안전한 생활습관을 기른다\'는 교육부와 어린이집, 유치원 새누리과정.신체운동.건강, 기본생활 영역에 제시된 안전교육내용에 맞추어 유아들이 건강하고 안전한 생활습관을 기를 수 있도록 구성된 안전교육동화이다. 소방차는 불이 나면 삐뽀삐뽀 사이렌을 울리며 출동하여 불을 꺼주고, 위험한 곳에 달려가 사람들을 안전하게 구해주는 고마운 소방차에요. 소방차의 구조와 역할을 이해하며, 탈것을 좋아하는 아이들의 호기심을 자극하고, 사고력을 쑥쑥 키워주는 안전동화입니다.', 25851.00, '9788967611026', 609, 'https://search.shopping.naver.com/book/catalog/32509130906', 29752.00, '도서출판대원', 3.2, 'https://shopping-phinf.pstatic.net/main_3250913/32509130906.20221227205533.jpg', 'WAIT', 87, true, false, false, '2023-05-15', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('강밀아', 3, '선생님은 너를 사랑해 왜냐하면 (2013 문화체육관광부 우수교양도서)', '일상적인 유치원 풍경에서 찾는 긍정의 에너지와 3만 볼트의 웃음 코드!

“너무 마음이 여려서” 혹은 “딴생각을 너무 많이 해서” “장난을 지나치게 많이 쳐서” 등 걱정거리로 생각될 수 있는 아이들의 특성을 일곱 명의 주인공을 통해 보여줍니다. 마음이 여려 눈물이 많은 고우나, 새 소식이든 헌 소식이든 모든 게 뉴스거리인 이르기쟁이 왕이륵, 힘이 세서 뭐라도 들어 올리고 보는 힘자랑쟁이 한영웅, 하나를 시작했다 하면 무조건 끝내고야마는 고집쟁이 구준히, 아이들 틈에서 어른을 흉내 내며 잘난 척하는 허풍이, 코딱지를 후비고 방귀를 뀌어서라도 친구들을 웃게 만드는 유쾌한, 샘이 많아 매 순간 누가 뭘 하고 어떻게 하는지를 지켜보고 따라하는 강새미가 그들이지요.
얼핏 보면 정신없을 이런 하루하루들 틈에 떡하니 중심을 잡고 있는 유치원 선생님의 목소리는 아이들에게 사랑을 고백하며 책장을 넘기게 합니다. 선생님이 울보 공주 고우나를 왜 사랑하는지 알면, 우나는 더 이상 울보 공주이기만 한 것이 아니라 따뜻한 마음의 씨앗을 가진 아이가 됩니다. 개성 강한 다른 아이들의 면면 또한 마찬가지로 모두 멋지게 자라날 씨앗임을 알려주는 선생님의 사랑 또한 참 멋집니다. 덧붙여 매 장면들을 자세히 보면 멈출 수 없는 웃음을 터트리게 됩니다. 선생님이 자신도 사랑할 거라는 믿음과 함께요!', 27043.00, '9788992704489', 849, 'https://search.shopping.naver.com/book/catalog/39588412628', 29605.00, '글로연', 4, 'https://shopping-phinf.pstatic.net/main_3958841/39588412628.20230919124341.jpg', 'CLOSE', 87, false, true, false, '2023-04-28', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('임상록', 9, '여름 섬 보물들 (한국어린이교육문화연구원 으뜸책 선정 도서)', '1970년대 남쪽 바다 어느 섬의 여름날을 오일파스텔 그림으로 담았습니다.

집 나간 염소를 찾고, 오리와 수영도 하고, 들개들과 싸우는 등 반려견 몽돌이와 함께한 자연에서의 삶이 다채롭게 이어집니다.

 유아들은 다양한 가축과 곤충, 꽃과 나무 등 자연환경을 담은 유화 느낌을 감상할 수 있고, 학생들은 반려동물들과 지내는 생태적인 삶을 체험할 수 있으며, 성인들은 조밀한 그림의 구석구석에서 어린 시절의 추억을 떠올릴 수 있습니다.

 그림의 기법은 초크아트(Chalk Art)라고 하는 상업미술의 일종인데, 분필로 메뉴 등을 기록하던 작업에서 유래되었다고 합니다. 현재는 발색이 좋고 번짐이 적은 오일파스텔을 이용해서 보드나 구조물 등에 그리는 거리 미술로 확장되고 있습니다. 본서의 모든 그림은 작가가 나무판에 그린 초크아트 작품을 옮긴 것으로 고유하고 따뜻한 정감을 간직하고 있습니다. 특유의 빈티지한 느낌이 오래된 기억을 기록하기에 적합하다는 생각에서 이 책을 만들었습니다.

전화도 텔레비전도 드물던 시절로 떠나는 레트로 시간 여행!', 34389.00, '9791198248510', 849, 'https://search.shopping.naver.com/book/catalog/40601768628', 39297.00, '지냄', 4.9, 'https://shopping-phinf.pstatic.net/main_4060176/40601768628.20230718122825.jpg', 'SUSPENSION', 97, false, false, true, '2023-06-12', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('허은미', 10, '불곰에게 잡혀간 우리 아빠 (2019 경남독서한마당 선정도서, 2019 전주 올해의 책 선정도서)', '기꺼이 불곰처럼 살아가는 엄마들에게 바치는 공감과 위로

화가 나면 얼굴이 불곰처럼 빨개지고 아침마다 집안을 들었다 놨다 하는 엄마는 별명이 불곰이다. 여느 날과 다름없이 소리치는 불곰에게 쫓겨 등교한 나는 ‘우리 가족’이란 제목으로 동시를 짓는다. 아빠, 동생, 순덕이(고양이)가 좋은 이유는 척척 쓰지만 “엄마는 왜 좋은지 모르겠다.”고 시를 맺은 나는 그때부터 엄마가 좋은 이유를 찾기 시작한다. 동생한테도 아빠한테도 엄마가 좋은 이유를 묻는데, 아빠는 엄마가 진짜 불곰이라며 믿을 수 없는 이야기를 들려준다. 나는 말도 안 된다고 반박하지만, “사슴처럼 여릿여릿한 아빠가 무시무시한 불곰한테 잡혀가는 모습이 자꾸자꾸” 떠오른다. 엄마는 진짜 불곰일까? 그래서 아침마다 그토록 으르렁대는 걸까? 정말 해가 뜨면 거죽을 벗고 사람이 되는 걸까? 불곰 같은 엄마가 좋은 이유를 찾는 아이가 본 진실은 무엇일까? 아이의 눈과 마음을 따라가다 보면, 어느새 뭉클한 공감과 위로가 햇살처럼 퍼져 나가고 나의 엄마 이야기를 듣고 싶게 만든다. 책을 덮고 나서 온 가족이 모여 앉아 엄마 이야기를 들어 보자.', 41050.00, '9788992351638', 854, 'https://search.shopping.naver.com/book/catalog/32478368241', 42640.00, '여유당', 1.6, 'https://shopping-phinf.pstatic.net/main_3247836/32478368241.20230912084032.jpg', 'ON_SALE', 35, true, false, false, '2018-01-25', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('편집부', 10, 'EQ(이큐)의천재들 모험시리즈 1~8권 세트 (전8권)', '', 13032.00, '', 165, 'https://search.shopping.naver.com/book/catalog/35568701618', 15418.00, '도서출판 무지개', 3.1, 'https://shopping-phinf.pstatic.net/main_3556870/35568701618.20221101095406.jpg', 'PROHIBITION', 24, false, false, false, '2018-01-01', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이미옥', 9, '손 씻고 냠냠 (어린이급식관리지원센터 위생교육 선정도서)', '〈손 씻고 냠냠〉 그림책은 이 시대를 살고 있는 영유아기 어린이들의 환경과 수준을 고려하여 생활 속에서 일어나는 여러 가지 상황에서 세균과 바이러스에 오염될 수 있음과 바른 손 씻기를 동화와 동요를 통해서 재미있고 쉽게 알려주고 있습니다.', 42690.00, '9791190884112', 812, 'https://search.shopping.naver.com/book/catalog/40212567629', 44370.00, '스토리메이커', 3.6, 'https://shopping-phinf.pstatic.net/main_4021256/40212567629.20230808085239.jpg', 'PROHIBITION', 6, false, false, false, '2022-07-15', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이미옥^황수영', 7, '똥은 다 알아! (어린이급식관리지원센터 위생교육 선정도서)', '〈똥은 다 알아!〉 그림책은 영유아기 어린이들의 수준을 고려하여 좋아하는 여러 가지 동물들을 등장시키면서 상상력과 호기심을 자극하며 영유아기 어린이들의 올바른 식습관 형성에 도움을 주고자 잘 구성되었습니다. 특히, 영유아기 어린이들에게 흥미로운 의성어와 의태어를 반복적으로 사용하여 감각적인 언어표현을 매우 효과적으로 전달할 수 있는 그림책입니다.', 32489.00, '9791190884105', 342, 'https://search.shopping.naver.com/book/catalog/40211338620', 34055.00, '스토리메이커', 2.4, 'https://shopping-phinf.pstatic.net/main_4021133/40211338620.20230920072551.jpg', 'ON_SALE', 44, false, false, false, '2022-07-01', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이혜리', 8, '속상해 (2023 북스타트 선정도서)', '일상에서 아이들이 느끼는 작은 좌절에 따뜻하게 공감하며, 유쾌하게 격려한다!
주위 사물에 마음을 투사하는 아이들의 심리를 해학적으로 그린 사랑스런 그림책.

엄마, 접시가 속상하대!
아침을 먹으려고 식탁에 앉았는데, 접시가 울상이다. 왜냐고? 접시 위엔 채소만 수두룩하고 소시지는 겨우 두 개! 그러니 접시가 속이 상해, 안 상해? 신발을 신으려고 신발장을 열었는데, 노란 고양이 장화가 시무룩한 얼굴로 쳐다본다. 왜냐고? 오늘은 나랑 꼭 같이 나가고 싶은데 비가 안 오잖아. 불쌍한 고양이! 엄마 손에 이끌려 버스를 타러 갔는데, 어라, 어린이집 버스도 속상한 얼굴이다. 왜냐고? 엄마랑 헤어지기 싫으니까!
주위 사물에 마음을 투사하는 아이들의 심리를 해학적으로 그린 그림책이다. 소시지, 완두콩, 브로콜리와 단호박 조각 담은 접시가, 하늘에 뜬 뭉게구름이, 멈춰선 버스가, 그저 구멍 몇 개 뚫린 나뭇잎이 저마다 어찌나 속상해 보이는지 절로 웃음이 난다.

내 마음을 알아주세요
“속상해.”는 “싫어.”나 “화가 나.”와는 결이 다르다. “나도 알아. 그렇지만…”이랄까, 수긍하면서도 욕구를 드러내는 방식이다. 그 뒤에 생략된 말은 “내 마음을 알아주세요.” “나랑 이야기 좀 해요. 나는요…”쯤 될 테다.
게다가 “나 속상해.”가 아니라 “접시가 속상하대.”라면 이런 능청, 이런 애교에는 호응을 해줘야 한다. 아무리 할 일 많고 마음 바쁜 엄마라도 목소리 높여 닦달하는 대신 눈치껏 “어머나, 왜? 접시가 왜 속상하대?” 하며 박자를 맞춰 줄 수밖에. 소시지 친구만 좋아하면 채소 친구들이 섭섭해 한다며 다독이고, 화창한 날이라도 하루쯤은 장화를 신겨 집을 나서 본다. 어린이집에서도 마찬가지. 다른 애들은 다 잘하는 가위질도 혼자만 못해 속상한 아이, 친구들 사이에 선뜻 섞이지 못하는 아이는 “선생님, 가위가 속상하대요.” “이파리가 속상하대요.” 하며 신호를 보낸다. 자, 얼른 응답하자! “어머나, 왜?” “어머나, 왜 그럴까?”

작은 좌절을 딛고 하루하루 성장하는 아이들에게
직장인 못지않게 아침부터 바쁜 아이들, 눈 뜨면 씻고 밥 먹고 옷 입고 스쿨버스를 놓칠세라 종종걸음을 친다. 두어 살만 되면 어린이집이며 유치원에서 이른 사회생활을 시작하는 아이들의 일상과, 그 일상을 즐겁게, 때론 힘겹게 소화하며 성장하는 모습을 담았다. 아직 낯가릴 게 많은 세상에는 하라는 것도, 하지 말라는 것도 너무 많아 속상하고, 두서없고 요령 없으니 느리고 어설퍼 속상하다. 일상에서 아이들이 느끼는 작은 좌절을 예민하게 포착하여, 살갑고 유쾌하게 격려하는 그림책이다. 정감 있는 캐릭터와, 다채로운 색감, 명쾌한 시각적 유머로 눈이 즐겁고, 일상에서 실제적인 육아 팁이 될 만한 다정하고 조곤조곤한 글에 마음이 따뜻해진다. 어린 독자들의 눈높이에서 어린 독자들의 마음을 두드리는 그림책.', 39082.00, '9788943314866', 628, 'https://search.shopping.naver.com/book/catalog/34563016626', 42255.00, '보림', 1, 'https://shopping-phinf.pstatic.net/main_3456301/34563016626.20230926084924.jpg', 'SUSPENSION', 72, false, false, false, '2022-09-15', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이소영', 6, '괜찮아, 나의 두꺼비야 (2022 세종도서 선정)', '사랑과 질투가 돌이킬 수 없는 잘못을 짓게 만들 때... 죄책감에 대한 이야기
사랑하는 친구에게 돌이킬 수 없는 잘못을 저질렀을 때

깊은 숲속 연못가에 오랜 친구인 흰 두꺼비 하양과 빨간 두꺼비 빨강이 함께 살고 있습니다. 하지만 이 둘은 아주 많이 달랐어요. 명랑하고 사교적인 하양은 많은 친구들과 어울리기를 좋아했고, 빨강은 집에서 조용히 혼자 보내는 시간을 더 좋아했어요. 하지만 빨강은 하양이 자신보다 다른 친구들과 더 친한 것 같다는 생각이 들자 마음이 불편해지기 시작했어요. 그러던 어느 날, 빨강은 하양이 동의도 없이 멀리 있는 친구를 둘이 함께 사는 집에 초대했다는 사실을 알고 화가 났어요. 사실 하양이 새 친구를 맞이하는 마음에 즐거움이 가득했기 때문에 시샘이 더해진 거예요. 날이 갈수록 감정이 악화되어 자신의 마음을 주체할 수 없었던 빨강은 하양에게 “그래! 가 버려!" 라며 옆에 있던 돌을 던지고 말았어요. 그 돌에 하양이 다쳐 병원으로 이송되자, 빨강은 죄책감에 시달리게 됩니다. 관계의 경계선을 넘어가며 몰아붙이는 빨강의 독점적인 사랑과 그에 따른 죄책감을 재치 있게 보여주는 흔치 않은 그림책입니다. 과연 빨강은 하양의 용서를 받을 수 있을까요? 그리고 무엇보다 자기 자신을 용서할 수 있을까요?', 5056.00, '9788992704915', 830, 'https://search.shopping.naver.com/book/catalog/32471347727', 10052.00, '글로연', 4.1, 'https://shopping-phinf.pstatic.net/main_3247134/32471347727.20240425093320.jpg', 'WAIT', 22, false, false, false, '2022-03-14', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김성은', 3, '웃음이 퐁퐁퐁 (2020 입학식에서 읽어주기 좋은 책 선정도서, 2019 가온빛 추천 그림책 선정도서)', '동동이와 세상 구경을 떠나며
여기 저기 마음을 주었던 퐁퐁이가(전작 〈마음이 퐁퐁퐁〉)
오늘은 웬일인지 기분이 나빠 보여요.
모자가 바람에 휭 날아가서래요.
동동이가 퐁퐁이를 위로하려고
\'깔깔바다\'에 가자네요!
깔깔바다에서는 모두가 웃어요.
갈매기가 낄룩낄룩, 조개가 헤헤헤, 해마가 캬캬캬!
어라? 웃다보니 기분이 좋아요.
웃어서 기분이 좋은 걸까요?
기분이 좋아서 웃은 걸까요?
나쁜 일도 물리쳐 주는 웃음의 힘!', 22304.00, '9791187287940', 884, 'https://search.shopping.naver.com/book/catalog/32486080493', 27069.00, '천개의바람', 4.2, 'https://shopping-phinf.pstatic.net/main_3248608/32486080493.20221019123803.jpg', 'OUT_OF_STOCK', 33, false, false, false, '2019-01-20', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이선미', 3, '나와 우리 (2014 세종도서, 서울시 한 도서관 한 책 선정)', '나와 너, 그리고 우리!

『나와 우리』는 똑같은 상황을 ‘나’와 ‘우리’의 두 입장에서 보여주는 독특한 구조의 그림책입니다. 아이들이 친구관계를 만들어가며 겪는 갈등 상황을 양쪽의 입장에서 볼 수 있도록 한 앞뒤 동시 펼침의 구성은 분희와 동네 아이들이 지닌 감정의 교차점을 속속들이 읽을 수 있도록 합니다. 이렇듯 나의 시각에서 보여진 순간들과 우리의 시각에서 보여진 순간들의 미세한 차이를 동시에 보여줌으로써 아이들이 상대방에 대한 이해의 폭을 넓힐 수 있도록 이끌어 줍니다.', 33951.00, '9788992704458', 155, 'https://search.shopping.naver.com/book/catalog/32487163566', 35019.00, '글로연', 4, 'https://shopping-phinf.pstatic.net/main_3248716/32487163566.20221019105904.jpg', 'OUT_OF_STOCK', 76, false, false, false, '2013-09-06', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김성은', 4, '마음이 퐁퐁퐁(빅북) (2018 북스타트 선정, 전국학교도서관사서연합회 선정, 2017 소년한국 우수어린이도서)', '햇살 따스한 날, 아기돼지 퐁퐁이가 세상 구경을 떠나요. 길가에 핀 꽃도, 춤추는 나비도, 노래하는 새도, 외로운 물고기도, 포슬포슬 보슬비도, 줄 타는 거미도, 하늘의 구름도, 길을 비춰 주는 조각달도, 퐁퐁이에게는 마냥 신기합니다. 퐁퐁이는 세상을 만날 때마다 자기 마음을 주었어요. 이런, 어쩌죠? 어느새 퐁퐁이 마음이 다 없어져 버린걸요. 괜찮아요! 마음은 아무리 주어도 줄어들거나 없어지지 않아요. 어느새 퐁퐁퐁 차오른답니다. 온 마음을 다해 멋진 세상을 누리고 즐기길 바라는 마음을 담은 아름다운 그림책입니다.', 45667.00, '9791187287605', 405, 'https://search.shopping.naver.com/book/catalog/32480305620', 47747.00, '천개의바람', 3.1, 'https://shopping-phinf.pstatic.net/main_3248030/32480305620.20230620100809.jpg', 'WAIT', 89, false, false, false, '2017-09-01', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김성미', 4, '인사 (2020 화이트 레이븐즈 선정도서)', '과연 누가 먼저 인사할 것인가?
오늘도 시작된 너와 나의 눈치 게임!

‘어! 옆집 아이네. 인사할까? 아냐, 아직은 좀 어색하지.’
‘어, 옆집 아저씨네. 인사할까? 아냐, 아직은 좀 쑥스러워.’

누구나 공감할 수밖에 없는 이야기를
누구도 생각지 못한 방식으로 들려준다!

[개요]
늑대 아저씨네 옆집에 여우 가족이 이사를 왔습니다. 늑대 아저씨와 여우는 눈이 마주치지만, 어색함에 첫인사를 나누지 못하고 서로 못 본 척 돌아섭니다. ‘다음에는 꼭 인사해야지!’ 마음먹지만 번번이 머뭇거리다 기회를 놓치고 말지요. 그러는 사이에 불편한 마음은 점점 커져 가고, 불필요한 오해도 점점 쌓여 가는데……. 과연 누가 먼저 인사할 것인가? 숨 막히는 눈치 게임이 유머러스하게 펼쳐집니다.', 17415.00, '9791158361655', 887, 'https://search.shopping.naver.com/book/catalog/32485856173', 19445.00, '책읽는곰', 1.2, 'https://shopping-phinf.pstatic.net/main_3248585/32485856173.20230725120356.jpg', 'SUSPENSION', 75, false, false, false, '2020-02-25', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이제경', 10, '할머니체조대회 (2022년 행복한 아침독서 추천도서, 2022년 제2회 도깨비 그림책 문학상 본심 선정도서, 2023 세종도서 교양부문 선정도서)', '열정과 즐거움이 가득한 할머니들의 체조 도전기!

"아, 아, 오늘은 할머니 체조대회가 열리는 날입니다."
한국, 몽골, 이탈리아 … 각 나라의 할머니들이 체조대회에 참가했습니다.
굽은 허리, 잘 들리지 않는 귀, 흐릿하게 보이는 눈…
늙고 힘없는 몸으로 도전하는 할머니들은 어떤 대회를 보여줄까요?
익살스러운 할머니들의 모습에서는 그녀들의 젊은 날과 꿈이 보입니다.
할머니들의 열정, 도전과 꿈으로 가득한 즐거운 체조대회에 여러분을 초대합니다.', 31176.00, '9791197173363', 399, 'https://search.shopping.naver.com/book/catalog/33642476622', 35803.00, '문화온도씨도씨', 3.1, 'https://shopping-phinf.pstatic.net/main_3364247/33642476622.20230919122726.jpg', 'OUT_OF_STOCK', 21, false, false, false, '2022-08-12', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('차재혁', 6, '말랑말랑한 이야기 (2021년 서울특별시교육청 어린이도서관 겨울방학 권장도서)', '말랑말랑한 질문이 생각났어

학교가 끝난 시간, 친구와 함께 도란도란 이야기를 나누면서 집으로 돌아가는 아이가 있었어요.
그런데 그때 말랑말랑한 질문이 하나 생각났어요.

행복이 뭘까?
행복은 어디에 있는 걸까?
또 어디에서 오는 걸까?

친구에게 물었어요. "넌 행복이 뭐라고 생각해?"
귀찮다는 표정으로 "나중에 다시 이야기하자."며 가 버리는 친구 얼굴에 아이는 더 궁금해졌어요.

\'행복이 대체 무엇일까?\'

가까우면서도 낯설게 느껴지는 이 질문에 사람들은 뭐라고 대답할까요?
아이는 집으로 돌아가는 길에 동네 사람들에게 물어보기로 결심했어요.

누가 어떤 대답을 했을까요?', 30869.00, '9791197519000', 240, 'https://search.shopping.naver.com/book/catalog/32464642620', 33970.00, '플라이쿠키(flycookie)', 1.3, 'https://shopping-phinf.pstatic.net/main_3246464/32464642620.20230725120846.jpg', 'CLOSE', 61, false, false, false, '2021-08-12', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김진', 10, '세종대왕을 찾아라 (2022 아침독서신문 선정도서, 2021 문학나눔 선정도서, 2021 소년한국 우수어린이도서, 2021 한국학교사서협회 추천도서, 초등 인물 2-2 교과서 수록도서)', '바람그림책 114권. 과거 시험이 있는 날이에요. 신하가 세종대왕을 깨우러 왔다가 깜짝 놀랐어요. 자리가 텅 비어 있었거든요. 곧 궁궐이 발칵 뒤집히고, 신하들은 임금님을 찾아 궁궐 안을 돌아다녔어요. 근정전부터 수라간까지 샅샅이 살펴보았지만, 세종대왕을 찾을 수가 없었어요. 신하들은 궁 밖으로 나갔어요. 놀이패를 지나치고, 물건들을 파는 시전을 둘러보고, 백성들이 양반을 피해 다니던 피맛길을 가 보았어요. 그러나 세종대왕은 찾을 수가 없었지요. 신하들은 흩어져서 사대문 밖까지 나가 보았어요. 동대문, 서대문, 남대문, 북대문. 하지만 어디에서도 세종대왕을 찾을 수는 없었답니다. 도대체 세종대왕은 어디로 사라진 걸까요? 갑자기 사라진 이유는 뭘까요?', 39194.00, '9791165731847', 687, 'https://search.shopping.naver.com/book/catalog/32467495978', 42284.00, '천개의바람', 4.5, 'https://shopping-phinf.pstatic.net/main_3246749/32467495978.20240831091036.jpg', 'CLOSE', 40, false, false, false, '2021-08-23', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이상희', 5, '17개의 질문', '2015년 유엔총회가 채택한 전 세계적인 목표 17개 항목(SDGs)에 대해 함께 생각하고 답하기 위해 그림책으로 제작하였다.', 33736.00, '9791197309007', 932, 'https://search.shopping.naver.com/book/catalog/32495452181', 37481.00, '도서출판 이음', 1.5, 'https://shopping-phinf.pstatic.net/main_3249545/32495452181.20230906071332.jpg', 'SUSPENSION', 21, false, false, false, '2020-12-30', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('허은실', 3, '나 비뚤어질거야 (2014 세종도서 문학나눔 선정도서)', '2013 볼로냐 올해의 일러스트레이터 선정작가 허은실의 그림책『나 비뚤어질꺼야』. 유치원에 갔다 오면 손부터 씻으라고 해서 그렇게 했더니……. "손만 씻으면 어떡해? 얼굴도 씻어야지!" 음식은 하나도 남기지 말라고해서 전시를 싹 비웠더니……. "네가 다 먹으면 어떡해?" 동생을 잘 돌보라고 해서 열심히 놀아 줬더니……. "또 동생 괴롭히니?" 이제부턴 엄마 말 안 들을 거야. 내가 하고 싶은 대로만 할 거야! 참고 참다가 화산처럼 폭발하지 말고, 엄마와 아이가 함께 웃음 짓고 행복할 수 있는 방법을 찾을 수 있도록 도와주는 그림책이다.', 27559.00, '9788953589353', 855, 'https://search.shopping.naver.com/book/catalog/32477571709', 29205.00, '한솔수북', 3.4, 'https://shopping-phinf.pstatic.net/main_3247757/32477571709.20230920071437.jpg', 'PROHIBITION', 23, false, false, false, '2013-10-29', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('홍미령', 3, '씽씽 갓도그 (아침독서 추천도서 선정)', '음악과 낭만, 즐거움이 가득한 ‘여수’에 뜬 씽씽 갓도그!
갓을 쓴 핫도그들이 펼치는 신나고 유쾌한 ‘갓’한 오디션

음악과 낭만, 즐거움의 도시 여수!
그 여수의 아름다운 섬들을 돌며 버스킹 공연을 하던 씽씽 갓도그 친구들이 갓밴드 오디션에 참가하게 되면서 겪는 에피소드를 재미나게 풀어낸 그림책입니다. 고래책빵 그림동화 20번째로 나왔습니다.
갓도그는 여수의 특산물인 ‘갓’과 남녀노소가 모두 좋아하는 ‘핫도그’를 접목시켜 탄생한 캐릭터들입니다. 점보 핫도그, 감자 핫도그, 체다 핫도그, 모짜 핫도그, 먹물 핫도그. 개성 넘치는 이 다섯 핫도그들이 갓을 쓰고 저마다의 멋진 갓도그로 재탄생합니다. 그리고 이들은 버스킹의 도시 여수에서 열리는 ‘세계 갓 밴드 오디션’을 향해 달려갑니다.
책은 독특하고도 매력이 가득한 갓도그들과 함께 아름답게 펼쳐진 여수의 배경과 화려하게 꾸며진 갓 섬 축제의 장면들을 마치 신나는 여행처럼 안내합니다. 이를 통해 여수가 지닌 매력과 볼거리, 먹거리, 즐길 거리를 자연스레 느끼고 만나게 합니다. 한편으론 책에 들어간 중독성 강하고 재미난 동요를 큐알코드 스캔만으로 즐기며, 유쾌함을 더하게 됩니다.

전 세계가 ‘갓’을 먹고 ‘갓’을 쓰고 ‘갓’을 외치는 ‘갓’ 난리아름다운 섬들을 돌며 신나는 음악을 부르던 씽씽 갓도그 밴드는 ‘세계 갓 섬 축제’에서 열리는 ‘갓 밴드 오디션’에 참가하기로 결심합니다. 하루도 쉬지 않고 열심히 연습한 갓도그 친구들. 그러나 오디션 하루 전날 노래를 담당하고 있는 주인공 점보에게 큰 위기가 닥칩니다. 목소리가 잘 나오지 않게 된 거죠.
돌돌섬에서 나는 최고의 갓인 ‘돌돌갓’을 먹으면 목이 좋아질 거라는 갓장군의 조언에 서둘러 돌돌섬으로 떠납니다. 우여곡절 끝에 얻은 귀한 돌돌갓으로 다양한 갓 요리를 해 먹은 점보는 전보다 더 맑고 우렁찬 천상의 목소리를 얻게 됩니다.
마침내 오디션 날이 되고 섬섬 투어하며 갈고닦은 실력으로 자신감에 찬 갓도그 친구들은 무대 위에서 씽씽 날아다닙니다. 마침내 갓도그 친구들은 일을 저지르고 마는데… 전 세계가 아주 갓 난리가 납니다.', 31034.00, '9791189879846', 126, 'https://search.shopping.naver.com/book/catalog/32438174093', 32367.00, '고래책빵', 4, 'https://shopping-phinf.pstatic.net/main_3243817/32438174093.20230425161940.jpg', 'ON_SALE', 32, false, false, false, '2022-04-22', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('박은정', 5, '책상 왈츠 (2023 북스타트 선정도서)', '당신이 잠든 사이, 책상 위에서는 …

볼펜, 가위, 줄자, 클립, 노란 고무줄. 낮 동안 사람들이 쓰고 자르고 재느라 사용했던 문구들. 누군가는 귀엽고 소중하게, 누군가는 대수롭지 않게 여길 작은 문구들. 우리가 잠든 사이, 문구들이 반짝 하고 눈을 떠, 평소의 제 쓸모에서 벗어나 자유롭게 춤을 춘다면 어떨까요? 당신이 잠든 사이, 책상 위에서는 문방구들의 왈츠가 시작됩니다.', 30623.00, '9788943314521', 165, 'https://search.shopping.naver.com/book/catalog/32620474619', 32266.00, '보림', 2.8, 'https://shopping-phinf.pstatic.net/main_3262047/32620474619.20230919124350.jpg', 'OUT_OF_STOCK', 79, false, false, false, '2022-06-01', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('최정선', 3, '반짝 (2023 북스타트 선정도서)', '상쾌하게 반짝이는 아침, 다정하게 건네는 아침 인사,
기분 좋은 하루를 약속하는 사랑스런 그림책

반짝이며 깨어나는 세상
어둑어둑한 대기가 술렁입니다. 밤새 풀잎에 서린 이슬이 또르르 굴러 내립니다. 반짝! 부옇게 동이 터옵니다. 풀잎마다 송골송골 맺힌 이슬이 진주알처럼 반짝입니다. 참새 둥지에선 바지런한 참새 한 마리가 반짝 눈을 떴네요. 단잠 자던 강아지도 반짝 잠이 깼고요. 지붕 위로 해님이 불쑥 솟으며 반짝 빛을 냅니다. 아기네 집 창가로 살금살금 기어오르던 나팔꽃은 햇살을 받아 힘차게 반짝, 반짝 꽃잎을 펼칩니다. “빰빠밤! 일어나세요. 아침이에요.”

반짝, 낱말 하나에 담긴 아침의 상쾌함
‘반짝’은 흔히 쓰는 부사예요. 보통 ‘반짝 빛난다’처럼 쓰지만 정신이 반짝 들거나 잠이 반짝 깬다고 할 때도 써요. 해결책이 반짝 떠오르고, 귀가 반짝 뜨이고, 손이나 고개를 반짝 들고, 눈을 반짝 뜬다고도 하지요. 그밖에도 다양하게 쓰여요. 생각보다 품이 넉넉하고 흥미롭고, 말맛이 풍부한 단어랍니다.
이 작은 그림책은 ‘반짝’이라는 낱말로 빛의 반짝임과 깨어남과 활기로 가득한 아침을 그려냅니다. 동이 트고 여명이 비추며 살아있는 것들이 잠에서 깨어나는 순간의 반짝임, 아침햇살을 받으며 활기가 되살아나는 세상의 아름다움을 ‘반짝’이라는 낱말 하나로 재치 있게 담아냈지요.

정답게 눈을 맞추고 활짝 웃으며 다정하게 건네는 아침 인사
그림은 일상의 순간들을 발랄하고 따뜻한 감성으로 그려 주목받고 있는 일러스트레이터 설찌가 그렸습니다. 화사한 색감, 특유의 위트 넘치는 캐릭터가 마음을 사로잡아요. 더할 나위 없이 귀엽고 사랑스럽습니다. 어쩐지 부활절 달걀을 닮은 듯한 참새나 활짝 웃는 나팔꽃, 눈을 동그랗게 뜬 아기 얼굴을 보면 절로 웃음이 터져요. 플랩을 이용하여 입체감을 준 엔딩 페이지는 책 읽는 재미를 더하지요.
단잠 자던 아기도, 밤새 뒤척이던 아기도 반짝 눈을 뜹니다. “아기님, 잘 잤어요?” 자, 이제 새로운 하루가 시작되었습니다. 오늘도 기운차게, 모두들 반짝반짝 신나게 놀아 보자고요.', 21338.00, '9788943314248', 459, 'https://search.shopping.naver.com/book/catalog/32477693166', 23301.00, '보림', 3.3, 'https://shopping-phinf.pstatic.net/main_3247769/32477693166.20230313184656.jpg', 'WAIT', 26, false, false, false, '2021-10-20', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('임경섭', 6, '미어캣의 모자 (2022 문학나눔 선정도서)', '“자, 이제 어떤 모자를 쓰고 싶은지 먼저 생각해 보렴.”
이 책은 평화와 생태, 다양성의 가치에 관해 이야기합니다.
재두루미가 사막의 미어캣을 찾아간 이유는?

어느 날 추운 지방에 사는 재두루미가 사막에 사는 미어캣을 찾아왔습니다. 재두루미는 미어캣에게 찾아온 이유를 이야기합니다.

“내가 살고 있는 마을은 얼마 전까지 큰 전쟁을 했어.
사람들은 다시 전쟁이 일어날까 봐 두려워서 마을에 긴 철조망을 쳤어.
그리고 다른 편을 쉽게 구분할 수 있도록
모두 같은 모양의 빨간 모자를 쓰고 살아가고 있어.”

마을에는 재두루미뿐 아니라 저어새, 수리부엉이, 반달가슴곰, 수달, 점박이물범, 고라니 등도 함께 살고 있었습니다. 사람들은 동물들에게도 똑같은 빨간 모자를 쓰라고 합니다. 그러나 그 모자를 쓰고는 동물들이 날 수도, 뛸 수도, 헤엄칠 수도 없었습니다. 동물들은 패션 디자인 경험이 많은 미어캣에게 도움을 청하기로 합니다.

재두루미와 함께 마을에 온 미어캣은 동물들과 함께 각자에게 편한 빨간 모자를 만듭니다. 동물들은 다시 뛰거나 헤엄치거나 날 수 있게 되었습니다.
그러나 계절이 바뀌자 사람들은 이제 노란 모자를 쓰라고 합니다. 그리고 얼마 후 다시 파란 모자를 쓰라고 합니다. 미어캣과 동물들은 이 상황을 어떻게 극복해 나갈까요?', 18423.00, '9788994750903', 628, 'https://search.shopping.naver.com/book/catalog/32466686020', 19517.00, '소동', 2.5, 'https://shopping-phinf.pstatic.net/main_3246668/32466686020.20230913071220.jpg', 'SUSPENSION', 86, false, false, false, '2021-12-10', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('노인경', 8, '고슴도치 엑스 (2015 화이트 레이븐즈 선정도서, 개정판)', '고슴도치 엑스, 씩씩하게 달려가다!

고슴도치가 고슴도치이기 위한 가장 소중하고 필수적인 조건은, 바로 \'뾰족한 가시\'에 있습니다. 하지만 이 가시를 허용하지 않는다면, 고슴도치의 삶은 어떻게 될까요? 『고슴도치 엑스』는 그런 통제와 금기 속에서 자신의 진짜 모습을 찾아가는 고슴도치의 이야기를 담은 그림책입니다. 《코끼리 아저씨와 100개의 물방울》의 저자 노인경의 신작으로, 흥미로운 설정과 탄탄한 서사 구조, 곳곳에 배치된 유머러스한 장치들이 읽는 재미를 더합니다.

고슴도치들이 오랜 세월 공들여 이룩한 완벽한 도시 \'올\'. 외부의 위험 요소로부터 완전히 차단된 그들만의 도시에서, 가시를 포함한 모든 날카로운 것은 엄격하게 금지되어 있습니다. 어느 날, 주인공은 도서관에서 금지된 책 한 권을 발견하게 되고, 이로 인해 고슴도치의 진짜 모습은 뾰족한 가시에 있다는 사실을 알게 됩니다. 부단한 훈련으로 마침내 자유자재로 뾰족한 가시를 세울 수 있게 된 주인공. 뾰족한 것을 금지하는 도시 속에서 그의 앞날은 어떻게 될까요?', 17244.00, '9788954625777', 868, 'https://search.shopping.naver.com/book/catalog/32490815109', 19162.00, '문학동네', 1.2, 'https://shopping-phinf.pstatic.net/main_3249081/32490815109.20221019125026.jpg', 'WAIT', 49, false, false, false, '2014-09-25', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('고상미', 5, '신발 신은 강아지(빅북) (2015 미국 어린이도서관협회 선정도서)', '“책이 커지면 함께 읽는 즐거움도 커져요!”
위즈덤하우스에서는 어린이 독자들에게 ‘함께 읽는 즐거움’을 선사하기 위해 많은 사람이 함께 읽기 좋은 빅북 그림책을 출간했습니다. 빅북 그림책은 일반 그림책보다 1.5배~2배 크게 만든 그림책으로, 유치원이나 학교의 수업, 도서관의 강연이나 전시 등 여럿이 함께하는 활동에서 다양하게 활용할 수 있습니다. 책의 크기가 커진 만큼 선생님, 부모님 그리고 친구들과 독서 경험을 나누며 호기심과 상상력, 책 읽는 즐거움도 키울 수 있습니다.
빅북 《신발 신은 강아지》는 미니와 엄마가 길에서 우연히 신발을 신고 있는 강아지를 만나면서부터 이야기가 시작됩니다. 미니는 주인을 잃어버린 듯한 강아지를 데려가 키우자고 조르고, 엄마는 신발을 신은 것을 보니 주인이 있는 게 분명하다고 하는데…….
섬세하고 사랑스러운 그림과 유머러스하지만 따뜻한 이야기가 독자들을 매료시키는 그림책!', 11862.00, '9791191766974', 743, 'https://search.shopping.naver.com/book/catalog/32490363866', 15017.00, '위즈덤하우스', 4.3, 'https://shopping-phinf.pstatic.net/main_3249036/32490363866.20221019150704.jpg', 'SUSPENSION', 2, false, false, false, '2021-11-10', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('서유진', 10, '우리의 둥지 (2023 행복한 아침독서 추천도서)', '나무가 울창한 숲을 떠나 도시 주변에 사는 작은 새 한 쌍!
서유진 작가의 예리하고 섬세한 시선으로 본 도시에는 정말 그들이 살 만한 공간이 있는 것일까?
매일 들리는 시끄러운 공사장의 포크레인에 사라져 가는 숲과 나무, 그 자리에 세워지는 아파트와 건물들.
과연 우리의 둥지의 모습도 안전한 걸까요?', 13206.00, '9791187991205', 281, 'https://search.shopping.naver.com/book/catalog/32490736291', 17387.00, '브와포레', 5, 'https://shopping-phinf.pstatic.net/main_3249073/32490736291.20230801120843.jpg', 'OUT_OF_STOCK', 4, false, false, false, '2022-02-17', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('윤구병', 8, '울보 바보 이야기 (4학년 2학기 국어 교과서 수록도서)', '사람들의 가슴이 얼어붙는 무서운 돌림병을 고친 울보 바보를 만나요!

배움이 삶이 되고 삶이 배움이 되는 변산교육공동체를 일구어온 윤구병이 쓰고 재일동포 그림작가 홍영우가 그린 『울보 바보 이야기』. 사람들의 가슴을 꽁꽁 얼어붙게 한 무서운 돌림병을 치유한 울보 바보의 이야기를 담아낸 그림책이다. 사람들은 마음을 닫고 자신만 챙기기보다는, 마음을 열고 서로 도우면서 더불어 함께 살아야 함을 일깨워준다. 특히 학교와 학원을 정신없이 오가면서 친구와의 경쟁에서 이길 생각만 하느라 감정을 솔직하게 드러내는 방법을 배우지 못한 아이들의 마음을 따스하게 토닥거려주고 있다. 농익은 선을 호탕하고 쾌활하게 휘덜러 따뜻하게 화려한 색으로 채운 정겹고 익살스러운 그림이 아이들의 흥미를 불러일으키면서, 울보 바보처럼 사랑의 마음을 갖도록 이끈다.', 40679.00, '9788992527309', 961, 'https://search.shopping.naver.com/book/catalog/32471918883', 41976.00, '휴먼어린이', 2.6, 'https://shopping-phinf.pstatic.net/main_3247191/32471918883.20221019131519.jpg', 'SUSPENSION', 22, false, false, false, '2010-05-03', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('서미숙', 3, '안동 시내버스 종점 기행', '종점에 가본 적 있으신가요?

여기 ‘안동의 시내버스 모든 노선 타보기’를 버킷리스트로 삼고 4년간 안동 24개 노선 시내버스를 타고 안동 구석구석을 누빈 작가의 종점 마을 여행기가 책으로 나왔다.

종점인 오지마을에 내려 자연을 만나고 문화재를 둘러보고 그곳에 사는 사람들을 만나 이야기를 나누고 사진으로 남겼다. 『종점 기행』은 2015년 봄부터 2019년 봄까지 향토문화의 사랑방 《안동》에 연재하면서 많은 사랑을 받았다.

안동에는 너무나 많은 문화재가 산재한다. 고향 안동에 대한 각별한 애정과 문화재에 관심이 많은 작가는 비교적 덜 알려진 곳, 가까운 곳이지만 새로 생긴 곳을 중심으로 시내버스 기행을 했다. 총 4부로 구성된 책에는 살강 마을, 절강, 무실, 서미, 월애, 오미 등 자연부락 이름이 등장해 정겹다.

몽실이가 떠나간 살강 마을 외딴집을 찾아가고, 금곡 시냇물에 발을 담그며 다슬기도 주웠다. 그곳 그 땅을 지키는 순박한 사람들을 만나고, 귀촌한 청년의 참살이도 들여다 보았다. 솟을대문 집 종손 종부의 애환도 듣고, 절집에도 들렀다. 스님과 인연이 닿으면 다담을 나누고 여의치 않으면 부처님과 오래 독대했다. 청정도량 툇마루나 정자에서 먼 산 바라기만으로도 족했다. - 서문 중에서-

“담배 모중 했니껴? 안주 할 때 안됐지요. 딴 일은 밭에 다 했니껴? 신 것만 해 놓으면 돼. 늦으면 늦은 대로 하면 되지 뭐.  (중략) 오기는 뭐하러 오니껴. 바쁜데 올 여게 어데 있니껴. 맹 서로 소식 다 듣고 사는데. 예, 드가입시더.”
                                                          - 본문 중에서-

등 안동 토박이말도 곳곳에 등장해서 구수하다.

‘길 위에 있을 때 가장 나답게 느껴진다.’는 서미숙 작가는
장대비에 처마 아래서 비를 피하게 해준 할머니, 막차가 올 때까지 따뜻한 아랫목을 내어준 할아버지, 징검다리를 건너다 물에 빠진 운동화를 말려준 청년의 고마움도 잊지 않는다.

서미 고샅길에 비녀 지른 할매는 아직도 마실을 가실까, 임동 아지매는 올겨울에도 손두부를 만드실까, 사과꽃이 지천이던 백자리 아지매네 청계는 여전히 알을 잘 낳고 있을까? 모두 궁금하고 보고 싶어 다시 종점에 가고 싶어 한다.

 “종점에는 그곳을 떠나지 못하는 사람들,
  다시 돌아와야만 했던 사람들의 사연이
  굽이굽이 서려있다”
                                    - 책 속에서-', 22046.00, '9791192142159', 204, 'https://search.shopping.naver.com/book/catalog/45092791619', 26176.00, '도서출판한빛', 3.4, 'https://shopping-phinf.pstatic.net/main_4509279/45092791619.20240106090907.jpg', 'CLOSE', 2, false, false, false, '2023-12-22', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김인자', 9, '책 읽어 주는 할머니 (2010 문광부 우수교양도서 선정)', '할머니도 내가 날마다 책을 읽어드리면 저절로 글자를 알게 될까?

\'작가가 읽어 주는 그림책\' 시리즈, 제1권 『책 읽어 주는 할머니』. 이 시리즈는 읽기 교육성과 더불어 듣기 교육의 중요성이 높아지고 있는 오늘날을 위해 기획되었습니다. 이 그림책은 글 작가 김인자의 엄마와 딸 사이에 있었던 사건사고를 그대로 풀어낸 것입니다. 가족간의 사랑에 대해서 일깨워줍니다. 그림 작가 이진희의 은은한 유화 기법의 그림은 아이들의 감성을 끌어당깁니다. 특히 그림 속에서 새로운 이야기를 발견해내도록 인도합니다. 날고 싶어하는 펭귄도 만날 수 있습니다.

우리 외할머니는 시골에 혼자 사십니다. 할머니는 조용히 지내시는 것을 좋아하지요. 할머니는 글자를 읽을 줄 모르십니다. 나는 책을 읽어주신 엄마 덕분에 글자를 쉽게 깨쳤습니다. 할머니도 내가 날마다 책을 읽어드리면 저절로 글자를 알게 되실지도 모릅니다. 할머니는 그림책을 좋아하십니다. 내가 그림책을 읽어드리면 깜깜하던 세상에 환해진다고 말씀하셨어요. 나는 잠자기 전에 할머니께 전화를 합니다. 그림책을 읽어드리려구요. 할머니는 내 목소리를 들으며 잠이 드는데…….', 29224.00, '9788992704151', 478, 'https://search.shopping.naver.com/book/catalog/32485005845', 31337.00, '글로연', 2.9, 'https://shopping-phinf.pstatic.net/main_3248500/32485005845.20221019131709.jpg', 'WAIT', 29, false, false, false, '2009-09-29', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김희경', 4, '나는요, (2020 화이트 레이븐즈 선정도서)', '자신이 누구인지 궁금한, 자신을 사랑하고픈 모든 이에게 선물 같은 그림책!!

여기, 자신이 누구인지 궁금한 아이가 있어요. 아이는 여러 동물들을 바라보아요. 사슴은 겁이 많아 작은 일에도 깜짝짬짝 놀란대요. 나무늘보는 자신만의 공간에 있을 때 편안하대요. 날치는 처음 도전할 땐 항상 온몸이 떨린대요. 그런데…… 나는 누구일까요? 동물 친구들을 마주보던 아이가 마침내 말했어요. 놀라운 반전 속에 충만함을 안겨 준 그 한마디는 무얼까요? 내 안에 있는 여러 모습을 떠올려 보고 표현하며, 나를 수용하고 사랑하도록 이끄는 사랑스러운 그림책입니다.', 13280.00, '9788992351799', 339, 'https://search.shopping.naver.com/book/catalog/32466956248', 14387.00, '여유당', 1.6, 'https://shopping-phinf.pstatic.net/main_3246695/32466956248.20230620100935.jpg', 'OUT_OF_STOCK', 38, false, false, false, '2019-08-15', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('최정인', 4, '거인의 정원 (2022 행복한 아침독서 추천도서)', '부끄러움이 많은 아이가 숲에서 거인과 파란 정원을 만나는 환상적인 모험을 그린 이야기이다.
최정인 작가 특유의 화려한 색감과 과감한 구도가 돋보이며, 우리의 맘 속에 어딘가에 있을,
거인의 존재를 통해 모두에게 위로와 희망의 메시지를 전하고 있다.', 34873.00, '9791187991182', 799, 'https://search.shopping.naver.com/book/catalog/32436254566', 39200.00, '브와포레', 4.3, 'https://shopping-phinf.pstatic.net/main_3243625/32436254566.20230801120924.jpg', 'PROHIBITION', 59, false, false, false, '2021-12-30', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('민트래빗 플래닝', 8, '별을 삼킨 괴물 (서울시교육청 선정 2016년 어린이 권장도서)', '『별을 삼킨 괴물』은 하늘의 별이 모두 사라져 버린다면 어떻게 될지 생각해 본 적 있나요? 괴물이 삼켜버린 별들을 구하러 초록이, 노랑이, 주홍이 세 아이들이 출동합니다. ‘별을 삼킨 괴물’은 어떻게 생겼을까요? ‘토끼의 쫑긋쫑긋 귀, 악어의 날카로운 이빨, 원숭이의 길쭉길쭉 꼬리’ 등 여러 가지 동물들의 모습을 닮은 괴물의 모습을 다양한 의태어로 표현하여 아이들이 동물의 특징을 잘 이해할 수 있도록 하였습니다.', 6339.00, '9791185419121', 593, 'https://search.shopping.naver.com/book/catalog/32438183989', 11186.00, '민트래빗', 2.2, 'https://shopping-phinf.pstatic.net/main_3243818/32438183989.20240611102140.jpg', 'CLOSE', 11, false, false, false, '2015-04-20', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김슬기', 10, '모모와 토토 하트하트 (2023 북스타트 선정도서)', '친구에게 진심을 전하고 싶을 때 《모모와 토토 하트하트》
모모와 토토

토토에게는 좋아하는 친구가 있어요. 바로 모모랍니다. 토토는 정성스럽게 그린 하트를 모모에게 주어요. 모모는 하트가 너무 좋았어요. 모모는 토토에게 하트를 많이 달라고 졸랐어요. 모모는 토토에게 받은 하트로 집 전체를 멋지게 꾸몄어요. 하트로 가득한 집을 친구들이 구경을 왔지요. 모모는 점점 더 하트를 많이 받고 싶고, 많은 하트는 모모를 우쭐하게 만들었어요. 그런데 언젠가부터 토토는 놀러 오지 않았어요. 토토에게 무슨 일이 생긴 걸까요? 모모는 토토의 집에 찾아가 보았지만 토토는 혼자 책을 보고, 피아노를 치고, 장난감을 갖고 놀면서 모모에게 더 이상 하트를 그려주지 않았어요. 토토랑 놀 수 없는 모모는 너무 심심해졌어요. 집으로 돌아온 모모는 곰곰이 생각하게 되었어요. 모모와 토토에게 하트는 무슨 의미일까요?', 8635.00, '9788943314873', 881, 'https://search.shopping.naver.com/book/catalog/34728530629', 11528.00, '보림', 4.7, 'https://shopping-phinf.pstatic.net/main_3472853/34728530629.20230829091339.jpg', 'ON_SALE', 74, false, false, false, '2022-09-27', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이영득', 6, '봄 숲 놀이터 (산림청 개청 50주년 기념도서)', '살랑살랑 봄바람 불면 봄 숲 놀이터로 놀러 오세요! 봄 숲이 이렇게 아름다웠나요? 봄 숲의 재발견! 『봄 숲 놀이터』. 소나무 굴을 걷다 보니 멧돼지와 고양이와 여우가 소꿉놀이를 하고 있었어요. 오소리는 통통한 버섯을, 고양이는 큰괭이밥 잎을, 강이는 집에서 밥을, 모두 한 가지씩 가져와 예쁜 꽃밥을 만들어 먹었지요. 맛있는 꽃밥을 배불리 먹고는 모두 그네를 타러 갔어요. 차례로 타고, 같이 타고, 모두가 걸걸걸 웃었어요. 산도 같이 거얼거얼 따라 웃었지요. 모두가 맛있게 먹고 하고 싶은 것을 하고 행복한 하루였어요.', 6727.00, '9788943311278', 331, 'https://search.shopping.naver.com/book/catalog/32472710987', 10656.00, '보림', 1.9, 'https://shopping-phinf.pstatic.net/main_3247271/32472710987.20230509165746.jpg', 'OUT_OF_STOCK', 43, false, false, false, '2017-11-23', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('진수경', 3, '귀신 님! 날 보러 와요! (2021 아침독서신문 선정도서)', '바람그림책 88권. 〈뭔가 특별한 아저씨〉의 작가 진수경의 신작 그림책입니다. 돌아가신 할머니가 그리운 영우. 죽으면 귀신이 된다는 오빠의 말을 듣고 영우는 \'귀신이라도 좋으니 할머니를 만나게 해 달라고 간절히 기도를 해요. 영우의 기도는 엉뚱하게 세계 여러 귀신에게 전해지는데… 과연 영우의 기도가 이루어질까요? 〈귀신 님! 날 보러 와요!〉는 사랑하는 사람이 죽으면 영영 볼 수 없다는… 두려움을 유쾌하고 감동적으로 담아낸 그림책입니다.', 18604.00, '9791190077361', 848, 'https://search.shopping.naver.com/book/catalog/32485033386', 23000.00, '천개의바람', 2.9, 'https://shopping-phinf.pstatic.net/main_3248503/32485033386.20221019120737.jpg', 'SUSPENSION', 86, false, false, false, '2020-02-25', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('서지연', 5, '후후후 (2021 아침독서신문 선정도서, 2021 북스타트 선정도서)', '후후후!
입술을 동그랗게 모아서 바람을 불어 봐요!
신나고 재미있는 일들이 일어날 거예요.

바람아기그림책 4권. 아이가 입술을 동그랗게 모아 ‘후후후’ 입김을 불어요. 그러면 동동동 떠오른 비눗방울이 멀리멀리 날아가요. 이번에는 종이배를 물에 띄우며 ‘후후후’ 입김을 불어요. 종이배는 아이의 바람을 타고 동실동실 떠간답니다. ‘후후후’ 입을 모아 바람을 불면 또 어떤 일들이 일어날까요? ‘후후후’ 입김을 불어보는 행동을 통해 여러 가지 상황을 놀이하며 즐길 수 있는 0~3세 그림책입니다.', 20792.00, '9791165730598', 268, 'https://search.shopping.naver.com/book/catalog/32436330813', 23633.00, '천개의바람', 1.3, 'https://shopping-phinf.pstatic.net/main_3243633/32436330813.20230313182602.jpg', 'SUSPENSION', 92, false, false, false, '2020-05-27', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('한유진', 10, '숲이 될 수 있을까? (책고래마을17, 세종도서 교양부문 선정작)', '어른들에게는 동심의 순수함을, 아이들에게는 자연을 향한 흥미를 일깨우는 이야기

어렸을 때부터 도시에서 나고 자란 아이들에게 숲은 낯선 곳입니다. 마음먹고 차를 타고 나가야 갈 수 있는 곳, 주로 텔레비전이나 인터넷으로 만나게 되는 곳이지요. 그러다 보니 숲에 대해서 흥미를 갖는 친구도 많지 않고, 종종 오해를 하기도 합니다. ‘지루하고 재미없는 곳’이라고 말이에요. 늘 한자리에서 계절에 따라 느릿느릿 옷을 갈아입는 숲을 보면, 아이들이 그런 생각을 할 만도 하지요. 하지만 가까이 가면 갈수록 숲에는 볼거리, 놀거리가 많답니다. 책고래마을 열일곱 번째 그림책 《숲이 될 수 있을까?》는 엄마와 함께 숲을 찾은 아이 이야기예요. 이른 아침, 아이가 엄마 손을 잡고 숲으로 산책을 나섰어요. 호기심 가득한 눈을 반짝이며 따라 나선 아이. 숲 안에는 몸과 마음을 즐겁게 하는 것들이 가득했어요. 기분 좋은 흙 냄새, 발가락을 간질이는 붉은색 흙. 어마어마하게 크고 멋진 나무……. 아이는 작은 발로 부지런히 뛰어다니며 숲과 친해집니다. 그리고 가슴 한가득 숲을 품고는 돌아오지요.

삭막한 도시 생활에 지친 사람들이 자연으로 자리를 옮겨 갑니다. ‘힐링’, ‘웰빙’이라는 말이 인기를 끌면서 숲을 찾는 발길도 늘고 있어요. ‘숲 해설가’라는 직업이 생겨날 만큼 관심도 높아졌습니다. 우리 아이들이 숲의, 나아가 자연의 품 안에서 자라날 수 있다면 얼마나 좋을까요? 흙을 밟고, 맑은 공기를 들이마시며 마음껏 뛰어놀 수 있다면 말이에요. 《숲이 될 수 있을까?》는 작가의 이런 바람이 담긴 그림책입니다. 숲에 있는 모든 것이 궁금하고 신기한 아이 이야기를 통해 어른들에게는 동심의 순수함을, 아이들에게는 자연을 향한 흥미를 일깨우지요. 아이와 함께 숲 산책을 나서 보는 것은 어떨까요? 《숲이 될 수 있을까?》 속 엄마와 아이가 그랬던 것처럼 말이에요. 함께 숲을 보고, 듣고, 만지면서 이야기를 나누는 거예요. 상쾌한 풀냄새를 한껏 들이마시기도 하고요. 집으로 돌아올 때쯤엔 아이도 엄마, 아빠도 숲이 되어 있을 거랍니다.', 17940.00, '9791187439448', 873, 'https://search.shopping.naver.com/book/catalog/32492054048', 19451.00, '책고래', 3.2, 'https://shopping-phinf.pstatic.net/main_3249205/32492054048.20240507081325.jpg', 'CLOSE', 79, false, false, false, '2017-07-31', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('신혜영', 10, '주세요 주세요 (2021 북스타트 선정도서)', '● 우리 아기 첫 의사표현을 배우는 말놀이 그림책 〈주세요 주세요〉
처음 말문이 트이면 아기들은 한 단어 중심으로 자신의 의사를 표현합니다. 그러다 점점 말할 수 있는 단어들이 늘면 부모들은 아기들에게 문장형 표현을 하도록 유도하지요. 그때 가장 먼저 가르치는 표현 중 하나가 바로 ‘OO 주세요.’라는 말입니다. 특히 맘마, 까까, 물 등이나 아기들이 주로 먹는 것 외에도 안아, 업어 등 하는 아기들이 주로 하는 행동에도 ‘주세요’라는 어미를 붙여 말하게 하지요. ‘주세요’라는 말은 아기가 원하는 것이 반영된 요구의 표현이자 동시에 정중한 부탁의 표현이기도 합니다.
〈주세요 주세요〉는 아기가 처음으로 자신이 원하는 걸 요구하고 부탁할 때 쓰는 의사 표현을 사랑스러운 그림과 귀여운 입말로 배울 수 있게 도와주는 아기 그림책입니다.
뿐만 아니라 책을 보면 아기들이 좋아하고 친숙한 동물들의 이름을 자연스럽게 알고 일상 생활과 관련된 다양한 소리와 모양을 흉내내는 말을 따라하며 다양한 어휘도 듣고 말해 볼 수 있습니다.

● 행동 맞추기, 흉내내기, 역할 놀이 등
사랑스러운 동물들을 보며 여러 가지 놀이를 해 보아요
〈주세요 주세요〉에는 아기의 모습과 꼭 닮은 여러 가지 아기 동물들이 등장합니다. 첫 장면에는 아기 동물들이 사랑스럽고 귀엽게 때로는 투정을 부리며 ‘주세요 주세요’라고 말하지요. 과연 아기 동물들이 그토록 원하는 건 무엇일까요? 바로 다음 장면에는 각 아기 동물들이 원하는 걸 엄마 아빠가 제공하면서 즐거워하는 모습이 등장하는데, 아기들과 책을 보며 맞추기 놀이를 하며 책장을 넘겨보면 더 즐겁게 책을 읽을 수 있습니다.
다음 장면에 등장하는 건 밥 먹기, 물 마시기, 놀기, 뽀뽀하기, 엎기, 안기 등 아기들이 일상 생활에서 매일 반복하는 모습들입니다. 아기들은 자기와 똑같은 모습을 하는 아기 동물들의 모습을 보며 동질감과 평안함을 느낄 수 있지요. 또 아기 동물들과 엄마 아빠 동물들이 하는 행동을 보며 꼴깍꼴깍 물을 마시거나 엄마 아빠와 뒹굴며 둥개둥개 놀이를 하고 쪽쪽 뽀뽀하는 모습을 직접 해 보거나 각 동물들의 익살스러운 표정 등을 흉내 내는 놀이도 할 수 있어요. 때로는 아기 동물과 엄마 아빠 동물의 역할을 바꿔서 역할 놀이를 하며 단순하게 책을 읽어 주는 게 아니라 다양한 상호작용을 통해 놀이를 하며 즐길 수 있는 그림책입니다.

● 베테랑 일러스트레이터 최미란 작가의 첫 아기 그림책
〈주세요 주세요〉의 그림을 그린 최미란은 오랫동안 다양한 어린이책 일러스트 작업을 하며 유쾌한 캐릭터와 재치 넘치는 연출로 많은 인기를 얻고 있는 베테랑 작가입니다. 2010년에는 볼로냐아동도서전에서 라가치상을 수상하며 우리나라 그림책이 세계적인 명성을 얻기 시작한 데 시작점이 된 작가이기도 합니다. 지금까지는 주로 초등학생을 대상으로 하는 그림책에서 발랄하고 익살스러운 작업으로 많은 사랑을 받았던 작가가 단행본으로는 처음 아기 그림책을 선보입니다.
여섯 동물들의 고유한 특징을 살리면서 아기들의 모습이 보는 듯 그대로 반영되어 아기들의 시선을 사로잡을 것입니다. 특히 첫 장면에서 반복되는 ‘주세요 주세요’에서의 각 아기 동물들의 생동감 있는 표정이나 다채로운 동작은 다음에 등장하는 행동이나 상황과 자연스럽게 연결되어 책을 보는 아기들에게 만족감과 안도감을 선사합니다. 베테랑 그림 작가의 귀여움과 사랑스러움이 가득한 아기 그림책을 만나 보세요.', 15125.00, '9791165731915', 517, 'https://search.shopping.naver.com/book/catalog/32486002649', 18938.00, '천개의바람', 3.9, 'https://shopping-phinf.pstatic.net/main_3248600/32486002649.20230207165129.jpg', 'CLOSE', 48, false, false, false, '2021-10-05', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('장준영', 5, '무슨 소리지? (책고래마을8, 세종도서 교양부문 선정작)', '우리가 일상에서 쉽게 만나는 소리를 다룬 그림책 『무슨 소리지?』. 자라나는 아이들에게 자연에 대한 관심을 키워 주는 것은 중요합니다. 자연 속에는 공부로 얻을 수 없는 생명의 가르침이 담겨 있으니까요. 이 책을 읽고 아이와 함께 공원을 산책하며, 놀이터를 뛰어다니며 자연이 들려주는 ‘소리’에 귀를 기울여 보세요.', 20245.00, '9791187439028', 478, 'https://search.shopping.naver.com/book/catalog/32438160923', 22148.00, '책고래', 3.4, 'https://shopping-phinf.pstatic.net/main_3243816/32438160923.20221019123608.jpg', 'CLOSE', 57, false, false, false, '2016-08-05', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이영득', 10, '봄 숲 놀이터(산림청 개청 50주년 기념도서)(빅북) (산림청 개청 50주년 기념도서)', '봄 숲에는 꽃이 가득, 아름다운 봄꽃은 무엇이 있을까요?
《봄 숲 놀이터》에는 봄꽃들이 한가득 있어요. 어떤 꽃들이 있을까요?

금낭화는 비단 주머니 같은 꽃이라는 뜻이래요. 그래서 ‘며느리꽃주머니’라는 별명이 있지요. 돌배나무는 산에서 절로 자라는 배나무 가운데 하나예요. 4월에 하얀 꽃이 피면 둘레가 다 환해져요. 복사나무는 복숭아나무라고도 불려요. 분홍빛 꽃이 잎보다 먼저 피지요. 산벚나무는 산에서 자라는 벚나무라는 뜻이지요. 봄에 산마다 산벚나무 꽃이 피면 산이 환하고 곱지요. 양지꽃은 양지쪽에서 잘 자라서 양지꽃이에요. 줄기가 뿌리에서 모여 나지요. 여러해살이풀이어서 오래된 양지꽃은 제법 큰 무더기로 자라지요. 책 속에는 더 많은 봄꽃이 있어요. 여러분들이 찾아보세요. 다 찾았다고요? 그럼 책 마지막 장 QR코드로 봄꽃들의 아름다움을 확인하세요.', 23418.00, '9788943311308', 560, 'https://search.shopping.naver.com/book/catalog/32439709945', 27442.00, '보림', 4.6, 'https://shopping-phinf.pstatic.net/main_3243970/32439709945.20230711113427.jpg', 'OUT_OF_STOCK', 77, false, false, false, '2017-12-20', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김명희', 10, '뿔 셋 달린 소 (서석도서관 사서 추천 도서, 세종도서 교양부문 선정작, 책고래 클래식 12)', '다른 것은 틀린 것이 아니에요
우리는 모두 ‘뿔 셋 달린 소’일 수 있어요

우리는 흔히 ‘다른 것’을 ‘틀린 것’으로 받아들이곤 합니다. 평범하지 않은 것, 내 기준에서 벗어난 것을 경계하고 날선 시선을 보내지요. 특히 여럿이 모인 자리에는 도드라지는 누군가가 나타나기 마련이고, 그는 곧잘 미움의 대상이 됩니다. ‘따돌림’이라고 부르는 못된 일에 앞장서지 않더라도 용기를 내지 못해서, 혹은 무관심으로 소외된 친구에게 다가서지 못했던 경험이 한번쯤은 있을 거예요.
책고래클래식 열두 번째 그림책 《뿔 셋 달린 소》는 독특한 생김새 때문에 괴롭힘을 당했던 가여운 소 이야기입니다. 책 제목에서 눈치 챌 수 있듯이 ‘뿔이 셋 달린 소’가 주인공이지요. 남들은 두 개인 뿔이 셋이나 달린 탓에 뿔 셋 달린 소는 다른 소들에게 따돌림을 당했어요. 집 안의 힘든 일도 도맡았지요. 고된 일에 시달린 끝에 뿔 셋 달린 소는 그만 목숨을 잃고 말았지요. 그런데 놀라운 일이 벌어졌어요. 지고 있던 쌀에서 바구미가 수 만 마리 생겨나더니 뿔 셋 달린 소를 괴롭히던 주인도, 주인네 집도 모두 집어 삼키는 것이 아니겠어요?
그저 뿔이 하나 ‘더’ 달렸을 뿐인데 소는 웃음거리가 되고 온갖 궂은일을 해야 했어요. 뿔 하나가 그렇게 큰 차이일까요? 뿔이 없는 동물의 눈에는 뿔이 둘이 있든, 셋이 있든, 하나가 모자라든 그저 이상하게 보일 텐데 말이에요. 한 걸음 물러서 보면 아주 작은 차이일 뿐이지요. 사람도 마찬가지랍니다. 나, 우리와 다르다고 해서 단단하게 벽을 세우고, 누군가를 밀어내지만 가만 살펴보면 별것 아닌 이유가 대부분이에요. 또 비슷비슷한 것 같아도 우리는 얼굴부터 성격, 살아가는 모습까지 제각각이지요. 어찌 보면 모두가 ‘뿔 둘 달린 소’가 아니라 ‘뿔 셋 달린 소’라고 할 수도 있어요.
《뿔 셋 달린 소》는 오늘날 우리가 타인을 대하는 태도와 시선에 대해서 돌아보게 만드는 이야기입니다. 나와 조금 다르다는 이유로 남을 업신여기거나 무시한 적은 없는지, 상대에게 상처를 주지는 않았는지 생각하게 하지요.', 46037.00, '9791165020392', 169, 'https://search.shopping.naver.com/book/catalog/32454137774', 48936.00, '책고래', 1.6, 'https://shopping-phinf.pstatic.net/main_3245413/32454137774.20221129172023.jpg', 'SUSPENSION', 35, false, false, false, '2020-09-04', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('장경선', 10, '비켜 비켜 (질서)', '[이든샘 인성 창작동화]는 유아기에 꼭 필요한 인성 덕목을 유아의 눈높이에 맞춰 흥미롭게 구성한 시리즈입니다. 질서, 정직, 효, 배려, 협력, 경청, 존중 등 앞으로 살아가는데 있어서 중요한 가치들을 배워 보세요. 엄마, 아빠와 함께 이야기를 나누며 놀이하듯 쉽게 인성교육을 할 수 있습니다. 더불어 귀여운 그림과 쉬운 내용은 아이가 책과 친해질 수 있도록 만듭니다.', 43680.00, '9791187341598', 623, 'https://search.shopping.naver.com/book/catalog/32497274773', 45838.00, '새늘(도서출판)', 2.1, 'https://shopping-phinf.pstatic.net/main_3249727/32497274773.20240619071258.jpg', 'ON_SALE', 36, false, false, false, '2017-02-20', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('안은영', 7, '할머니 어디 있어요? (2020 책날개 선정도서, 2020 학교도서관저널 추천도서, 2020 아침독서신문 선정도서)', '온 세상이 조용하고 까만 밤이 되면 아이는 할머니가 더욱 그립습니다. 혹여 할머니를 만날까 할머니와의 따뜻하고 소중한 추억을 하나하나 떠올려 봅니다. 할머니와 함께 보던 밤하늘의 반짝이던 별들, 할머니와 함께 놀던 장난감과 인형들, 할머니가 읽어 주던 그림책들 그리고 할머니의 온갖 보물이 담겨 있던 상자까지요. 하지만 할머니에 대한 그리움만 더욱 진해질 뿐입니다. 꿈에서 할머니를 만날 수 있지 않을까 잠을 청해 봅니다. 아이는 할머니를 만날 수 있을까요?', 42884.00, '9791187287988', 602, 'https://search.shopping.naver.com/book/catalog/32466711824', 44680.00, '천개의바람', 4.4, 'https://shopping-phinf.pstatic.net/main_3246671/32466711824.20221019124158.jpg', 'ON_SALE', 14, false, false, false, '2019-04-17', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이은선', 3, '까만 카멜레온 (책고래마을21, 세종도서 교양부문 선정작)', '몸의 색도, 마음의 색도 다른 까만 카멜레온 이야기 [까만 카멜레온]. 까만 카멜레온은 몸의 색이 변하지 않아요. 숲 속을 뛰어다닐 때도, 꽃들 사이를 거닐 때도 그저 ‘까만색’일 뿐이지요. 친구들은 까만 카멜레온을 두고 ‘왜 변하지 않을까?’ 이상하게 여깁니다. ‘어른이 되면 달라질까?’, ‘조금 더 기다리면 예뻐질 거야’ 저마다 추측을 하지요. 의심스러운 눈으로 바라보는 친구들에게 까만 카멜레온은 그저 미소를 지어 보일 뿐입니다.', 30296.00, '9791187439516', 597, 'https://search.shopping.naver.com/book/catalog/32443840840', 33306.00, '책고래', 2.5, 'https://shopping-phinf.pstatic.net/main_3244384/32443840840.20221019104501.jpg', 'OUT_OF_STOCK', 84, false, false, false, '2018-01-19', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('박진영', 4, '공룡을 키우고 싶어요 (2020 한우리 선정 도서)', '무시무시한 치과 치료도 용감하게 이겨 낸 내 소원은…… 공룡을 키우고 싶어요!

안녕, 친구들. 오랜만이지? 나야 나, 공룡 박사! 너희에게 빨리 들려주고 싶은 엄청난 이야기가 있어. 있잖아, 아빠가 나랑 약속했어. 무시무시한 치과에 가서 용감하게 치료를 받으면, 소원을 들어주기로! 난 약속을 지켰고, 아빠는 물었지. 게임기 사 줄까? 놀이동산에 갈까? 땡! 내 대답은 이거야. 공룡을 키우고 싶어요! 자, 이제부터 날 따라와. 얼른 공룡 분양센터로 함께 가자고! 워워, 너무 흥분하지 마. 그러다 넘어질라, 조심조심! 공룡을 만나러 GO!

[줄거리]
공룡을 키우고 싶어요! 그런데 아빠는 다 안 된대요. 나를 지켜 줄 공룡은 사나워서, 순한 공룡은 키가 너무 커서, 작은 공룡은 햄순이를 잡아먹을 것 같아서, 나뭇잎을 먹고 사는 공룡은 너무 빨라서, 엄청 느린 공룡은 물건을 망가뜨려서, 착한 공룡은 너무 시끄러워서, 조용한 공룡은 수영장이 필요해서, 수영장이 필요 없는 공룡은 얌전하지 않아서……. 휴, 제가 키울 수 있는 공룡은 도대체 어디 있는 걸까요?', 38282.00, '9791160512847', 270, 'https://search.shopping.naver.com/book/catalog/32441079093', 42214.00, '씨드북', 2.2, 'https://shopping-phinf.pstatic.net/main_3244107/32441079093.20221019132016.jpg', 'ON_SALE', 59, false, false, false, '2019-08-05', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이은선', 10, '변했으면 변했으면 (책고래마을7, 세종도서 교양부문 선정작)', '《변했으면 변했으면》은 매일 사나운 개에게 쫓기던 고양이가 여러 동물로 변하는 과정을 재미있게 표현한 그림책입니다. 어린 시절 누구나 한번쯤 특별한 재주를 가진 사람, 혹은 초능력자가 되길 꿈꾸었을 거예요. 어른이 되어서도 종종 현실의 내가 아닌 다른 누군가가 되기를 바라곤 하지요. 《변했으면 변했으면》은 고양이의 ‘변신’을 통해 현실에 지친 아이들은 물론 어른의 마음까지 들여다보게 하는 그림책입니다.', 46145.00, '9791195590698', 772, 'https://search.shopping.naver.com/book/catalog/32485598737', 48237.00, '책고래', 2.3, 'https://shopping-phinf.pstatic.net/main_3248559/32485598737.20230502163941.jpg', 'OUT_OF_STOCK', 26, false, false, false, '2016-05-11', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('홍건국', 4, '이상한 항아리 (정직, 욕심내지 않는 마음)', '욕심내지 않는 마음

지나치게 욕심을 부리면 도리어 화를 입게 돼요. “선물이란 마음을 표시하는 것이요. 욕심이 과하면 복을 주어도 화를 당합니다.” 항아리 장수는 남은 항아리를 들고 휭하니 사라져 버렸답니다.', 45275.00, '9791185721286', 234, 'https://search.shopping.naver.com/book/catalog/32504139682', 49819.00, '황우(도서출판)', 1.1, 'https://shopping-phinf.pstatic.net/main_3250413/32504139682.20221227205427.jpg', 'ON_SALE', 41, false, false, false, '2016-06-01', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('정재원', 3, '토끼에게 물어보세요 (2022 북스타트 선정도서)', '시치미 떼기 대장과 장단 맞추기 대장이 등장했다!
손발이 척척, 장난꾸러기 커플의 익살맞은 가면놀이

우리 윤이가 어디 갔을까? 혹시 윤이 못 봤어요?
“토끼에게 물어보세요.” 책 제목이에요. 그런데 무얼요? 무얼 물어보라는 거죠? 궁금증을 안고 책장을 열었어요. 얼굴이 하얀 토끼가 눈을 동그랗게 뜨고 있네요. 엄마가 물어요. “어머나, 귀여운 토끼네. 토끼야, 안녕! 혹시 우리 윤이 못 봤니?” 아하, 엄마가 윤이를 찾는군요. 토끼가 대답해요. “글쎄요. 야옹이한테 물어보세요.” 저런, 토끼는 윤이가 어디 있는지 모르나 봐요. 그럼 야옹이는 알까요? “야옹 씨, 멋쟁이 야옹 씨, 우리 윤이 못 봤어요?” “글쎄요.” 야옹이도 모르나 봐요. 꽃들에게 물어보래요. 그런데 뭔가 수상해요. 토끼랑 야옹이 옷이 똑같아요!

가면 쓴 아이와 엄마의 능청스런 겨루기 한판
아이들이 좋아하는 가면 놀이가 익살스런 그림책이 되었습니다. 가면을 쓴 아이와 엄마가 놀이를 해요. 한두 번 해 본 솜씨가 아닌 듯 손발이 척척 맞아요. 이 가면, 저 가면 바꿔 쓰며 능청스레 역할을 바꾸는 아이와 장단 맞춰 놀아 주는 엄마, 둘이 주고받는 대화가 생생하고 재미납니다. 화려한 색상, 간결하고 위트 넘치는 캐릭터가 어린 독자들의 눈을 단박에 사로잡고요. 가면뿐 아니라 바구니, 포스터, 보자기 등 다양한 도구를 활용한 점도 좋고, 축구공처럼 엉뚱한 가면이 등장하는 것도 흥미로워요. 언제쯤 아이의 정체가 드러날지 책장을 넘길 때마다 살짝 설레기도 한답니다. 실제로 가면놀이를 해볼 수 있도록 귀여운 가면도 하나씩 들어 있어요.

*성취감과 자신감, 상상력을 길러 주는 놀이
영유아기 아이들은 소꿉놀이나 가면놀이, 병원놀이처럼 ‘다른 누구인 척’하는 놀이를 좋아합니다. 자아 개념이 형성되고 일상의 경험이 늘고 지적 능력이 발달했다는 증거예요. 아이들은 이런 상상놀이를 통해 상상력과 사고력, 현실 대응 능력을 기릅니다. 책 속 엄마처럼 아이에게 공감하고 함께 놀아 주면 아이는 성취감과 자신감을 맛보지요. 양육자와 함께 하는 놀이는 유아기에 가장 중요한 안정적인 애착 형성에 큰 도움이 돼요. 놀이를 통해 정서적인 안정감과 유대감을 느끼고 긍정적인 자아상, 대인관계에 대한 신뢰감을 갖게 되거든요.
아이들에게 놀이는 삶이자 배움입니다. 아이들과 놀아 주세요. 이 책에 든 ‘야옹이 가면’이나 ‘멍멍이 가면’을 활용해 보세요. 아이들과 직접 가면을 그리거나 만들며 놀면 더욱 좋겠지요.', 26868.00, '9788943314095', 151, 'https://search.shopping.naver.com/book/catalog/32471919549', 29425.00, '보림', 3.3, 'https://shopping-phinf.pstatic.net/main_3247191/32471919549.20221019132026.jpg', 'OUT_OF_STOCK', 90, false, false, false, '2021-08-25', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('안성하', 4, '할머니 집에 살아요 (세종도서 교양부문 선정작)', '우리 주위에는 다양한 가족의 모습이 있습니다. 하루하루 화목하고 웃음 가득한 가족이 있는가 하면, 그렇지 않은 가족도 있지요. 《할머니 집에 살아요》는 우리가 흔히 생각하는 것과는 조금 다른 가족의 이야기를 그리고 있습니다. 그리고 가족의 의미에 대해서 다시 돌아보게 만들지요. 할머니 집에 사는 일곱 악동을 한번 만나 볼까요?', 20072.00, '9791187439202', 553, 'https://search.shopping.naver.com/book/catalog/32436278707', 23343.00, '책고래', 4.9, 'https://shopping-phinf.pstatic.net/main_3243627/32436278707.20240220081601.jpg', 'SUSPENSION', 42, false, false, false, '2017-05-04', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이수연', 6, '시원한 책 (초등 2학년 국어교과서 수록도서)', '‘시원하다’에 담긴 수많은 의미
바람이, 국물이, 마음이…
아무튼 엄청나게 시원한 책!

국립국어원에서 ‘시원하다’를 검색하면, 무심코 썼던 다양한 의미의 표현들이 펼쳐집니다.
다양한 의미를 담고 있는 ‘시원하다’라는 말은 우리말의 섬세하고도 감수성 풍부한 매력을 느낄 수 있는 아주 좋은 예지요. 하지만 섬세한 만큼 우리 아이들은 헷갈리고 어렵게 느껴지기도 합니다.
 뜨거운 매운탕 국물을 먹고 시원하다 외치는 아빠를 보며, 팔팔 끓는 탕 속에서 벌건 얼굴로 시원하다 나직이 내뱉는 엄마를 보며 아이들은 고개를 갸우뚱합니다. 뜨거운 국물이, 팔팔 끓는 물이 시원하다니 황당하기 짝이 없지요.
 이러한 대한민국 수많은 아이들의 가려운 곳을 속 시원히 긁어 주기 위해 〈시원한 책〉이 출간되었습니다. 이 책을 덮는 그날부터 오래 참았던 오줌을 겨우겨우 누었을 때, 가려운 등을 누가 긁어 줬을 때, 어느 여름날 장대같이 쏟아지는 소나기를 보며 “시원-하다!”라는 말이 입에서 절로 터져 나오는 자신을 발견한 것입니다.', 37394.00, '9791164631810', 166, 'https://search.shopping.naver.com/book/catalog/32483347692', 39227.00, '발견(키즈엠)', 3.6, 'https://shopping-phinf.pstatic.net/main_3248334/32483347692.20240402070927.jpg', 'OUT_OF_STOCK', 48, false, false, false, '2020-07-05', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김상근', 3, '별 낚시 (2020 화이트 레이븐즈 선정도서, 일본 MOE그림책서점대상 수상 도서)', '“아무리 애를 써도 잠이 오지 않는 밤이 있어. 모두가 잠든 밤에 혼자만.”
깊은 밤, 혼자만 깨어 있는 너에게 들려주는 이야기

따스한 이야기꾼 김상근 작가의 신작
푸른 밤하늘로 날아오르는 근사한 모험

자려고 누웠는데 말똥말똥, 억울할 만큼 잠이 오지 않는 밤이 있다. 모두가 잠들어 고요하기만 한 집 안. 살금살금 발소리도 조심하며 나온 거실 바닥엔 한 줄기 달빛이 내리쬔다. 누가 있는 걸까? 생각하며 아이가 말을 걸자 아주 신기한 일이 일어났다. 하늘에서 달랑달랑 내려온 밝은 별 하나. 폴짝, 어디 한 번 올라 타 볼까?

언제나 선물처럼 기분 좋은 이야기를 들려주는 작가 김상근의 새 그림책이 나왔다. 이번엔 새하얀 눈밭이 아니라 푸른 밤하늘, 빛나는 별 천지로 우리를 초대한다. 장면마다 가득 펼쳐지는 신비로운 밤하늘 풍경은 고요한 밤에만 느낄 수 있는 차분하고 깊은 감성을 톡톡 건드린다. 마치 기다렸다는 듯이 내려온 별을 타고 멋지게 날아오르는 아이의 모습을 보고 있으면, 앞으로 펼쳐질 이야기가 궁금하지 않을 수 없다.', 45655.00, '9791160944600', 965, 'https://search.shopping.naver.com/book/catalog/32445208046', 47454.00, '사계절', 2.5, 'https://shopping-phinf.pstatic.net/main_3244520/32445208046.20230627102308.jpg', 'OUT_OF_STOCK', 63, false, false, false, '2019-04-22', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김난지', 9, '김치가 최고야 (2016 한우리 독서올림피아드 선정, 2015 아침독서신문 선정, 2015 오픈키드 좋은어린이책 목록 추천도서, 2014 동원 책꾸러기)', '우리 김치들의 자기 자랑 이야기를 들어볼까요?

우리 밥상에서 빠지지 않는 반찬, 김치. 『김치가 최고야』는 옛이야기 《규중칠우쟁론기》에서 모티브를 얻어, ‘우리가 자주 먹는 다섯 김치들이 자기가 최고라고 뽐낸다면 무엇을 자랑할까?’ 하는 재미있는 발상에서 기획되었다고 합니다. 이야기는 우선 가을 밭의 채소가 개성 넘치는 항아리 속 다섯 김치로 변신하는 과정부터 시작됩니다.

다섯 김치들은 가장 자신 있는 몸짓을 하며 자기 개성을 뽐냅니다. 동치미는 헤엄을 치고, 깍두기는 탑 쌓기를 하며, 파김치는 나풀나풀 쭈욱 날씬한 몸매를 자랑하고, 총각김치는 알통을 뽐내지요. 마지막으로 배추김치 역시 넙적한 배추 잎을 펼쳐 꽃밭을 만듭니다. 밝은 색감으로 올망졸망 표현된 그림은 이런 김치들의 특징을 생생하면서도 즐겁게 보여 줍니다.', 33468.00, '9788997984350', 854, 'https://search.shopping.naver.com/book/catalog/32438286763', 35030.00, '천개의바람', 2.2, 'https://shopping-phinf.pstatic.net/main_3243828/32438286763.20230927071316.jpg', 'PROHIBITION', 71, false, false, false, '2014-09-02', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('천미진', 4, '멸치 대왕의 꿈 (초등 4학년 필독도서)', '“멸치 대왕의 꿈은 용이 될 꿈일까요, 멸치구이가 될 꿈일까요?”
다양한 생각과 상상을 이끌어 내는 [멸치 대왕의 꿈] 이야기

[멸치 동해 바다에 사는 삼천 살 먹은 멸치 대왕은 어느 날, 아주 묘한 꿈을 꾸었습니다. 갑자기 몸이 하늘 높이 휙 치솟았다가 금세 아래로 훅 떨어지고, 함박눈이 펑펑 내리다가 날씨가 더웠다 추웠다를 반복하는 희한한 꿈이었지요. 멸치 대왕은 곰곰 고민을 하다 재빠른 가자미를 불러 꿈풀이를 잘하기로 소문난 서해 바다의 망둥이를 데려오라고 했습니다. 가자미는 갖은 고생을 다하며 망둥이를 데려왔지만, 멸치 대왕은 가자미에게는 고맙다는 말조차 하지 않고 망둥이만 극진히 대접했습니다. 이후 망둥이는 멸치 대왕의 꿈을 용이 될 꿈이라 풀이했고, 가자미는 멸치 대왕이 멸치구이가 될 꿈이라고 해석했습니다. 멸치 대왕은 가자미의 말에 크게 화가 났고 한바탕 소동이 벌어집니다. 과연 가자미는 어떻게 되었을까요? 또 망둥이와 가자미의 꿈풀이 중 무엇이 맞는 것이었을까요?

[멸치 대왕의 꿈]은 꿈 해몽을 소재로 여러 바다 생물들의 생김새에 대한 유래를 재밌게 담아 낸 옛이야기 그림책입니다. 이 책은 이야기적인 재미가 있을 뿐만 아니라, 다양한 생각과 상상을 이끌어 내며, 다른 사람의 입장과 상황을 이해하는 과정을 자연스럽게 배우게 합니다.', 8552.00, '9788967494186', 226, 'https://search.shopping.naver.com/book/catalog/32476763312', 13531.00, '키즈엠', 4.5, 'https://shopping-phinf.pstatic.net/main_3247676/32476763312.20240417100550.jpg', 'SUSPENSION', 32, false, false, false, '2015-09-21', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김정선', 10, '오나, 안 오나? (책나눔위원회 2022년 11월 추천도서)', '사랑스럽고 귀여운 아이와 강아지가 눈빛과 눈길과 몸짓으로
설렘, 기다림, 즐거움, 다정함, 편안함, 사랑을 전하는 그림책입니다.

김정선의 새 그림책이 출간되었습니다. 《오나, 안 오나〉》는 새로 산 우산과 장화와 비옷을 입고 놀고싶은 아이와 강아지의 설렘, “오나, 안 오나?” 먹구름 가득한 하늘을 올려다보며 비를 기다리는 마음, 비 놀이의 즐거움과 아이와 강아지를 지켜보는 따뜻한 마음이 가득 담긴 그림책입니다.', 32268.00, '9788976505767', 367, 'https://search.shopping.naver.com/book/catalog/34374983625', 35344.00, '산하', 1, 'https://shopping-phinf.pstatic.net/main_3437498/34374983625.20230516164519.jpg', 'CLOSE', 41, false, false, false, '2022-09-05', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('강밀아', 8, '착한 아이 사탕이 (문광부우수교양도서)', '착한 아이도 울고, 투정 부리고, 화를 내요!

『착한 아이 사탕이』는 섬뜩할 정도로 착한 사탕이가 참 자아를 찾아가는 모습이 익살스러우면서도 통쾌하게 그려진 그림책이다. 사탕이는 착한 아이다. 울지도 않고, 말썽꾸러기 동생에게 화도 내지 않는다. 하지만 착한 사탕이의 얼굴엔 표정이 없다. 우는 모습도, 투정을 부리는 모습도, 화를 내는 모습조차도 사탕이에게선 찾아볼 수가 없다. 그런데 어른들은 그런 사탕이가 착하다고 입을 모아 칭찬할 뿐이다. 그때 사탕이도 알지 못하는 사탕이의 속마음인 그림자가 나타난다. 그리곤 사탕이에게 ‘나’를 표현하는 법을 알려주고 용기를 준다. 사탕이는 화날 때는 화를 내고, 울고 싶을 때는 울기도 하며, 동생과 다투고 싶었던 속마음을 하나씩 표현해나간다. 이 책은 아이들에게 자신의 참 모습에 대해 돌아보고 생각할 기회를 준다.', 38761.00, '9788992704328', 159, 'https://search.shopping.naver.com/book/catalog/32462605723', 42983.00, '글로연', 2.5, 'https://shopping-phinf.pstatic.net/main_3246260/32462605723.20240827090324.jpg', 'PROHIBITION', 82, false, false, false, '2011-12-05', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이진희', 10, '어느 날 아침 (2019 일본 MOE 서점인 추천 도서, 개정판)', '뿔을 찾아 여행을 떠난 사슴!

잃어버린 뿔을 찾아 떠난 사슴의 이야기를 담아낸 그림책 『어느 날 아침』. 아름다운 뿔을 가진 사슴이 있었습니다. 그러던 어느 날 아침에 눈을 떠보니 그 아름답던 뿔 하나가 갑자기 사라졌습니다. 깊은 슬픔에 빠져있던 사슴은 기운을 차려 뿔을 찾아 여행을 떠나기로 합니다. 사슴은 과연 잃어버린 뿔을 찾을 수 있을까요?

소중한 뭔가가 사라지는 순간은 갑자기 다가옵니다. 숲속 유리집에 살고 있는 아름다운 뿔을 가진 사슴도 그랬답니다. 아이들과 어른들 모두와 소통할 수 있는 이 그림책을 통해 아이들과 어른들 모두 상실에 일희일비하지 않으며, 눈곱만큼의 오차 없이 다가올 긍정의 미래를 확신하고 따뜻함을 나누며 삶을 대해나갈 수 있는 힘을 얻게 됩니다.', 34961.00, '9788992704632', 184, 'https://search.shopping.naver.com/book/catalog/32496301842', 37740.00, '글로연', 1.4, 'https://shopping-phinf.pstatic.net/main_3249630/32496301842.20230920072402.jpg', 'OUT_OF_STOCK', 81, false, false, false, '2018-11-25', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김난지', 10, '밥이 최고야 (2015 북스타트 플러스, 오픈키드 좋은그림책 목록 추천도서, 2014 아침독서신문 선정)', '가지가지 곡식이 모두 목욕탕으로 모여요!

익살맞고 유쾌한 곡식 목욕탕 이야기 『밥이 최고야』. 우리가 먹는 밥그릇 속 곡식들을 정겨운 친구처럼 만나는 그림책입니다. 그동안 자그마해서 눈여겨보지 않았던 밥그릇 속 곡식 하나하나를 들여다보며 관찰해 봅니다. 강낭콩, 누에콩, 서리태, 메주콩, 완두콩, 작두콩 같이 콩들은 빛깔도 가지가지, 크기도 가지가지, 맛도 가지가지입니다. 똑같은 줄 알았던 쌀도 하얀 빛깔 멥쌀과 영양 만점 현미, 검은빛이 도는 흑미까지 종류가 여럿입니다. 꼬물꼬물 사랑스런 곡식에 대한 호감이 밥에 대한 친근감으로 이어져 밥 먹기가 즐거워지는 그림책입니다.', 18341.00, '9788997984121', 972, 'https://search.shopping.naver.com/book/catalog/32436257152', 19741.00, '천개의바람', 4, 'https://shopping-phinf.pstatic.net/main_3243625/32436257152.20230523091826.jpg', 'ON_SALE', 46, false, false, false, '2013-07-22', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이장미', 10, '달에 간 나팔꽃 (2020 우수출판콘텐츠 제작 지원 선정작, 2021 북스타트 선정 도서)', '원대한 꿈을 꾼 나팔꽃과 개미의 이야기

어느 날, 낮달을 본 나팔꽃은 달에 꼭 가보고 싶었습니다. 나팔꽃은 초록 열매로 변하는 여름이 와도, 갈색 열매로 변하는 가을이 와도, 까만 씨앗이 되어 깜깜한 흙 속에 묻히는 겨울이 와도 달에 가겠다는 다짐을 거듭합니다. 다시 봄을 맞은 나팔꽃은 휙휙 하늘을 가르며 달을 향해 나아갑니다.
지구 끝까지 다다른 나팔꽃은 아주 멀리에 있는 달을 보며 크게 실망을 하지만, 나팔꽃은 한 번 더, 달에 꼭 가기로 다짐을 합니다. 쉽지 않은 우주에서의 여정을 이겨내고 마침내 달에 도착한 나팔꽃은 부지런히 꽃봉오리를 만들어 활짝 꽃을 피웁니다. 그때 개미가 달에 도착합니다. 달까지 어떻게 왔냐는 나팔꽃의 물음에 개미는 최선을 다해서 왔다고 답을 합니다.
작가는 무엇인가를 이루기 위해 가장 중요한 부분은 다짐과 다짐을 거듭하며 마음을 단단하게 하는 것이라고, 그리고 최선을 다하는 것이라는 말을 나팔꽃과 개미를 통해 전하고 있습니다.', 45895.00, '9788992704786', 775, 'https://search.shopping.naver.com/book/catalog/32441786861', 47333.00, '글로연', 1.9, 'https://shopping-phinf.pstatic.net/main_3244178/32441786861.20230425164328.jpg', 'ON_SALE', 96, false, false, false, '2020-10-01', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김수정', 9, '우리 엄마는 바지 위에 팬티를 입어요 (책고래마을12, 세종도서 교양부문 선정작)', '요가를 하는 특별한 엄마, 평범하지 않은 엄마가 못마땅한 아이. 아이들 눈에 비친 엄마는 어떤 모습일까요? 맛난 음식을 만들고, 어려운 숙제를 도와주고, 모르는 것을 척척 알려주고……. 엄마는 무엇이든 할 수 있고, 세상으로부터 나를 지켜줄 수 있는 대단한 사람처럼 느껴집니다. 꼭 슈퍼맨처럼이요. 그런데 엄마가 보통 사람과 조금 다르다면 어떨까요? 눈에 띄는 옷을 입고, 유별난 행동을 한다면 말이에요.

책고래마을 열두 번째 그림책 《우리 엄마는 바지 위에 팬티를 입어요》는 특별한 엄마의 이야기입니다. ‘요가’를 하는 엄마 이야기지요. 아이는 요가복을 입고 동네를 다니는 엄마가 못마땅합니다. 게다가 엄마는 맨날 몸으로 이상한 동물을 만들지요. 그림책을 더 읽어주었으면 좋겠는데 말이에요. 평범하지 않은 엄마가 창피한 아이. 하지만 체육대회를 계기로 엄마를 바라보는 아이의 시선이 달라지기 시작합니다.

부모라면 누구나 아이들에게 떳떳하고 자랑스러운 엄마, 아빠이길 바랍니다. 하지만 살아가는 일이 그리 녹록치만은 않지요. 때로는 아이들 보기가 멋쩍은 순간도 있고, 감추고 싶은 모습도 있습니다. 남들의 따가운 눈초리나 수군거림을 묵묵히 견뎌내야 하기도 하지요. 철없는 친구들에게 놀림 받으며 아이들은 더러 마음이 다치기도 합니다. 우리는 아이들을 어떻게 대해야 할까요? 《우리 엄마는 바지 위에 팬티를 입어요》는 이런 고민을 읽을 수 있는 그림책입니다. 이야기를 빚은 김수정 작가는 엄마의 모습을 통해서 명쾌하게 해답을 제시합니다. ‘움츠리지 말고, 당당하게!’라고요.

‘가족’이라는 이유로 생겨나는 상처가 있습니다. 그런가 하면 가족이기에 더 깊이 이해하고 끌어안을 수 있지요. 《우리 엄마는 바지 위에 팬티를 입어요》는 가족, 그리고 관계에 대해서 돌아보게 합니다. 엄마, 아빠는 아이의 마음을 살피게 되고, 아이는 부모의 입장을 헤아리게 되지요. 가족에 대한 걱정의 목소리가 높아지는 요즘, 아이와 이야기를 나눠 보는 건 어떨까요?', 6054.00, '9791187439158', 997, 'https://search.shopping.naver.com/book/catalog/32504368749', 10698.00, '책고래', 2.8, 'https://shopping-phinf.pstatic.net/main_3250436/32504368749.20221019123438.jpg', 'WAIT', 80, false, false, false, '2017-02-15', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이현주', 4, '나무처럼 (책고래마을6, 세종도서 교양부문 선정작)', '《나무처럼》은 낡은 5층 아파트에 이사 온 은행나무가 자라는 과정, 시간의 힘을 보여 주는 그림책입니다. 1층 높이였던 나무가 점점 키가 자라 2층, 3층, 4층, 5층까지 자라면서 보고, 듣고, 느낀 이야기를 담담하게 표현하고 있습니다. 겉으로 드러나는 이야기는 나무의 성장담이지만, 좀 더 깊게 글과 그림을 읽어 나가다 보면 그것이 작가의 자전적인 이야기임을 눈치 챌 수 있습니다. ‘창문’을 통해 세상을 내다보는 시간, 홀로 견뎌내야 할 ‘밤’의 시간…. 더불어 독자들은 하루하루를 힘겹게 살아 내고 있는 스스로의 삶을 돌아보게 됩니다. 그래서 은행나무가 마침내 하늘을 향해 가지를 쭉 뻗었을 때, 다시 한 번 ‘희망’을 떠올리게 됩니다.', 25387.00, '9791195590674', 720, 'https://search.shopping.naver.com/book/catalog/32505843030', 29827.00, '책고래', 4.1, 'https://shopping-phinf.pstatic.net/main_3250584/32505843030.20240703071048.jpg', 'OUT_OF_STOCK', 89, false, false, false, '2016-04-15', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이은경', 6, '질문의 그림책 (제3회 보림창작스튜디오 수상작, 2023 북스타트 선정도서)', '“상상의 한계를 넘어 새로운 세계로”
제3회 보림창작스튜디오 수상작

질문은 어디에서 오지?
우리는 어떤 현상을 맞닥뜨릴 때에 그에 대한 답을 찾으려 합니다. 가끔은 정답이 정해져 있지 않은 질문을 하면서 자유롭게 상상을 해 보는 건 어떨까요? 작가는 아무도 질문하지 않았던 것들을 질문하며 독자를 시적 상상의 세계로 이끕니다. 평범한 사물이 새로운 의미를 가지게 되는 놀라운 장면을 그린 그림책입니다.

상상의 한계를 넘어 새로운 세계로,
사라진 만두는 어디로 여행을 떠난 걸까?
평화롭고 한적한 시골 마을이에요. 맑고 푸른 하늘 아래, 햇빛을 받고 길쭉하게 자라난 벼들이 보여요. 새끼 오리들이 일렬로 산책을 나서고 염소들은 풀을 뜯고 놀아요. 노란 꽃밭에서 장난치는 고양이들 너머로는 무게를 잡고 선 꿩들이 보입니다. 먼 발치에 서서 무엇을 바라보고 있는 걸까요? 멀리서부터 줄지어 만두 기차가 다가옵니다. 고소한 증기를 뿜어내면서요. 이질감이 느껴지는, 그야말로 그동안 본 적 없는 풍경이에요. 그리고 작가는 독자에게 말합니다. “사라진 만두는 어디로 여행을 떠난 걸까?” 하고요. 《질문의 그림책》만의 시적 상상의 세계가 이제 막 펼쳐진 참이에요.

내면을 들여다보는 메시지,
내 안의 아이는 알고 있을까?
우리가 아는 그 무화과 맞나요? 무화과가 사랑스러운 새의 모습을 하고 하늘을 날아요. 무화과들은, 혹은 새들은 어디서 와서 어디로 가는 걸까요? 고요한 이곳은 도무지 폭풍이 찾아올 것 같아 보이지 않아요. 잔잔한 물결이 일렁이는 강, 맑고 선명한 구름이 빛나고 있는 걸요. 우리가 모르는 어떤 일들이 일어나고 있는가 봐요. 그럼, 다시 무화과에게 초점을 맞추어 감상해 보도록 해요. 이들의 생김새는 무화과 같기도, 새 같기도 한 것이 어떤 쪽으로 보든 꽤 그럴 듯하게 보이지 않나요?

《질문의 그림책》의 세계에서는 일상적이지 않은 일들이 페이지마다 새로이 펼쳐져요. 옥수수 팝콘이 꽃망울로 표현되고, 개구리와 빨간 딸기와의 경계는 점점 사라지죠. 수박이 반으로 쪼개어진 모습은 마치 화산 폭발을 연상하고요. 늘어선 가로수들 중에서 아이스크림으로 보이는 것들도 있는데, 이 모든 게 다 어찌된 일일까요? 작가의 한계 없는 상상력으로 만들어진 이 공간에서 낯선 풍경들은 아무렇지 않은 듯이 자리해 있어요. 등장하는 사람들도 이 기이한 풍경을 이상하게 여기지 않고 자신들의 할 일을 해요. 공을 차고 놀거나, 유유자적 배 위에 떠 있기도 하고요, 낙타를 타고 본인의 갈 길을 나아가지요. 원래 세상은 이렇게 생겼다는 듯이요. 작가가 시작한 질문이 독자를 통해 꼬리에 꼬리를 물며 그림책의 세계는 더 확장되어요. 이 수많은 질문들은 어디로 사라질까요? 내면의 목소리를 듣고 이야기 나누어 보아요.', 25511.00, '9788943312503', 366, 'https://search.shopping.naver.com/book/catalog/32439585006', 29355.00, '보림', 3.8, 'https://shopping-phinf.pstatic.net/main_3243958/32439585006.20221019141726.jpg', 'CLOSE', 36, false, false, false, '2020-03-23', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('신혜영', 5, '출동! 아빠 자동차 (2020 아침독서신문 선정도서)', '아빠와 아이가 즐겁게 놀이를 하다가 다급한 상황이 생겨요. 그러면 아빠는 멋진 자동차로 변신해서 출동하지요. 아이와 아빠는 함께하는 다양한 놀이의 즐거움을 느끼면서 서로간의 유대감을 쑥쑥 키워갑니다. 더불어 다양한 자동차의 이름과 기능도 알려주는 0~3세 그림책입니다.', 16408.00, '9791190077224', 592, 'https://search.shopping.naver.com/book/catalog/32441654529', 17690.00, '천개의바람', 1.8, 'https://shopping-phinf.pstatic.net/main_3244165/32441654529.20221019110018.jpg', 'WAIT', 27, false, false, false, '2019-10-18', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김난지', 3, '김치가 최고야(빅북) (2016 한우리 독서올림피아드 선정, 2015 아침독서신문 선정, 2015 오픈키드 좋은어린이책 목록 추천도서)', '김치는 종류가 참 다양합니다. 주재료가 되는 채소가 무엇이냐에 따라, 어떻게 만드느냐에 따라 각기 다른 김치가 됩니다. 만약 여러 김치들이 스스로 자기 소개를 한다면 뭐라고 말할까요? 『김치가 최고야』는 옛이야기 \'규중칠우쟁론기\'에서 모티브를 얻어, ‘우리가 자주 먹는 다섯 김치들이 자기가 최고라고 뽐낸다면 무엇을 자랑할까?’ 하는 재미있는 발상에서 기획되었습니다. 이야기는 우선 가을 밭의 채소가 개성 넘치는 항아리 속 다섯 김치로 변신하는 과정부터 시작됩니다.', 31660.00, '9791187287582', 972, 'https://search.shopping.naver.com/book/catalog/32439244355', 34118.00, '천개의바람', 3.2, 'https://shopping-phinf.pstatic.net/main_3243924/32439244355.20221019131455.jpg', 'SUSPENSION', 31, false, false, false, '2017-09-01', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김미영', 7, '아빠나무 (2017 경남독서한마당 초등부 추천도서)', '『아빠나무』는 아빠의 죽음을 겪은 아이가 상처받은 마음을 치유해 과는 과정을 천천히 따라갑니다. 아이는 아빠의 죽음을 몇 번이고 되풀이해서 생각합니다. 함께 한 시간들을 되새기고, 돌아가신 날을 떠올립니다. 그러다 아빠의 빈자리가 선명해지면 자기를 두고 떠나 버린 아빠를 원망하고, 아빠를 미워했던 기억이 떠올라 괴로워하기도 합니다. 그러던 어느 날 아이에게 말을 건네는 아빠의 목소리가 들립니다. “넌 혼자가 아니야. 아빠는 늘 너와 함께 있어.” 어쩌면 아빠로부터 꼭 듣고 싶었던 말을 떠올리며 스스로 다독이는 것인지도 모르죠. 아이만의 방식으로 충분히 애도의 시간을 보낸 아이가 비로소 아빠의 죽음을 받아들이고 마음속 보이지 않는 곳에 아빠의 자리를 만들게 된 것입니다.', 9328.00, '9788992505598', 269, 'https://search.shopping.naver.com/book/catalog/32489569188', 11907.00, '고래뱃속', 2.9, 'https://shopping-phinf.pstatic.net/main_3248956/32489569188.20230418164100.jpg', 'SUSPENSION', 36, false, false, false, '2016-11-07', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('엄지', 7, '하늘 수영장', '‘해가 쨍쨍한 맑은 날, 갑자기 비가 내린다면?’
질문이 만들어 낸 특별한 수영장에 놀러오세요.

“어어? 해님이 있는데 비가 내리네?”
“아하! 구름이 하늘 수영장에서 수영을 하나 봐!”

『하늘 수영장』의 이야기는 ‘왜 맑은 날에 비가 내리지?’라는 질문에서 시작됩니다. 맑은 날 갑자기 떨어지는 빗방울에 아이는 하늘을 올려다보고, 파란 하늘에 둥실둥실 떠있는 구름을 발견합니다. 그리고 그 하늘이 시원한 수영장처럼 느껴지자 아이는 구름이 하늘 수영장에서 물장구를 쳐서 비가 내리는 것이라는 상상을 합니다.

상상력은 질문에서부터!

전문가들은 4차 산업의 핵심이 ‘상상력’에 있다고 말합니다. 빠르게 변하는 미래에는 독창적인 생각으로 문제를 해결할 수 있어야 하기 때문입니다. 그리고 경험하지 않은 것을 마음으로 그려보는 힘인 상상력을 기르기 위해서는 질문이 필요합니다.

‘하늘 수영장’은 질문이 만들어 낸 특별한 수영장입니다. 하늘 수영장을 생각해낸 주인공 짱이는 하늘로 올라가 구름과 수영을 하고 싶다는 꿈을 꿉니다. 짱이는 과연 그 꿈을 이룰 수 있을까요? 하늘 수영장은 어떻게 가야할까요? 캥거루처럼 뛰어서? 아니면 그네를 타고 슝슝 날아서?

꼬리에 꼬리를 물고 이어지는 질문이 아이의 상상력을 자라게 할 것입니다. 『하늘 수영장』은 상상하는 것의 즐거움을 나누는 책입니다.', 11207.00, '9791197109195', 609, 'https://search.shopping.naver.com/book/catalog/33971744622', 14808.00, '도서출판 현정', 1.7, 'https://shopping-phinf.pstatic.net/main_3397174/33971744622.20230829091614.jpg', 'CLOSE', 8, false, false, false, '2022-08-15', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('정설희', 4, '별난 요리사의 행복 레시피 (생활 이야기 (행복, 힐링, 요리), 2015 세종도서 문학나눔)', '행복을 꿈꾸는 힐링 그림책!



스트레스가 어른들에게만 해당되는 것은 아니랍니다. 우리 아이들도 스트레스와 걱정이 만만치 않은데, 그러다보니 입맛이 떨어지기도 하고 잠을 설치기도 합니다. 건강한 스트레스 해소법은 도대체 없는 걸까요?



사소하고도 늘 새로운 걱정거리로 매일매일 잠 못 이루는 마을에 맛없는 요리 때문에 꿀꿀이 밥집으로 불리는 식당이 있었어요. 요리사는 어떻게 하면 사람들이 좋아하는 맛있는 요리를 만들 수 있을지 고민하다가 어느 날. 온 동네를 휘젓고 다니며 아그작, 빠그작, 깨물고 맛보고 상상하고 또 맛을 보다가 새로운 맛을 발견하면 스스로 행복해지고 즐거워지는 경험을 합니다.



아하! 별난 요리사는 그 때부터 식당 문을 닫고 요리 삼매경에 빠지지요.', 20012.00, '9788994975719', 773, 'https://search.shopping.naver.com/book/catalog/32492084470', 22065.00, '노란돼지', 1.1, 'https://shopping-phinf.pstatic.net/main_3249208/32492084470.20221228072251.jpg', 'SUSPENSION', 83, false, false, false, '2015-01-12', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('정재은', 5, '꼼짝 마! 충치균 (어린이급식관리지원센터 위생교육 선정도서)', '어린이급식관리지원센터 위생·영양교육 선생님이 직접 쓴 책!
어린이급식관리지원센터 선정도서

우리아이들의 이를 반짝반짝하고 튼튼하게 지켜주는 그림책!
아이들이 성장하면서 올바른 생활 습관을 배울 시기에 특히 올바른 양치 습관은 아이들을 건강하게 자라게 하는 데 아주 중요합니다. 《꼼짝 마! 충치균》 이야기를 통해 이 닦기를 싫어하는 아이들도 즐겁게 스스로 이 닦기를 할 수 있게 도와주는 그림책입니다.
꿈꾸는 놀이터 시리즈 1권~ 7권에서 채소를 싫어하는 아이들에게 채소 섭취의 중요성을 재미있게 알려주었다면 8권 《꼼짝 마! 충치균》에서는 이 닦기 싫어하거나 두려워하는 아이들에게 엄마의 잔소리나 설명보다는 《꼼짝 마! 충치균》을 보여주며 칫솔 치약과 자연스럽게 친해지도록 도와줍니다.
달콤한 간식을 정신없이 먹고 있는 아이를 몰래 지켜보던 충치균이 친구들을 데리고 왔네요. 충치균은 달콤한 간식을 아주 좋아해요. 아이의 입속에 몰래 숨어들어 간 충치균들은 달콤한 냄새가 나는 어금니 사이사이 혓바닥 밑에 꼭꼭 숨었지요. 충치균들은 깜깜한 밤이 되면 이에 남아있는 달콤한 음식들을 갉아먹고 이를 콕콕콕 찌르고 까맣게 만들 생각에 신이 나 있었지요.
하지만 충치균들 기분 좋아하는 것도 잠깐, 충치균이 무서워하는 칫솔에게 들켜서 입 밖으로 쫓겨날까 봐 더 꼭꼭 숨었지요. 이때 칫솔이 나타났어요. 칫솔은 눈을 크게 뜨고 충치균이 숨어있을 것 같은 곳을 구석구석 살펴보는 거예요. 충치균들은 칫솔에게 들키지 않으려고 숨도 쉬지 않고 더 꼭꼭 숨었어요. 과연 칫솔은 충치균들을 찾아낼 수 있을까요?
아이들의 치아 건강에 꼭 필요한 양치 습관을 길러주기 위해서 아이들 눈높이에 맞춰 재미있게 표현했어요.
아이의 입속으로 들어가려고 호시탐탐 노리던 충치균들과 칫솔, 치약의 활약을 통해서 아이들에게 올바른 양치 습관과 왜 이를 깨끗이 닦아야 하는지도 스스로 알게 하며 무엇보다, 칫솔이 먼저 몰래 숨어있는 충치균을 발견하고 칫솔과 치약이 힘을 합해서 입 밖으로 쫓아내는 모습과 아이들 눈높이에 맞춰 쓴 글과 그림이 정말 재미있습니다, 어린이 여러분, 이를 깨끗이 닦지 않으면 충치균이 잇몸을 피나게 하고, 붓게 하고, 너무나도 아프게 합니다. 그래서 음식, 간식을 먹은 후에는 반드시 이를 닦아야 해요. 그러려면 칫솔 치약과 자연스럽게 친해져 익숙해져야 합니다.

아이 스스로 이 잘 닦게 해주는 그림책
아이 스스로 이 닦는 습관을 갖게 하기는 참으로 어려운 일입니다. 스스로 양치하는 습관을 갖게 하려면 『꼼짝 마! 충치균』을 보여주세요. 이 닦기를 싫어하는 아이들도 스스로 이 닦는 것을 싫어하거나 거부하지 않고 즐겁게 ‘치카치카 푸카푸카’ 이 닦기를 할 겁니다. 칫솔과 치약을 무서워하는 충치균은 칫솔과 치약에게 들키지 않으려고 꼭꼭 숨어 있다가 눈을 크게 뜨고 찾던 칫솔에게 잡히고 칫솔은 치약과 함께 충치균을 입속에서 내쫓는 이야기가 아이 스스로 충치균을 물리치는 건강한 생활 자세가 될 거예요. 《꼼짝 마! 충치균》은 우리나라 엄마들에게 이 닦기 생활 습관 그림책으로 오랫동안 사랑받을 책입니다.
이 닦기의 중요성을 아이들 눈높이에 맞춰 재미있는 그림과 글로 표현
충치균은 달콤한 간식을 아주 좋아해요. 사탕, 초콜릿, 케이크 젤리 주스 등. ‘어디서 달콤한 냄새가 나지? 여기다!’ 달콤한 냄새가 나는 곳을 찾은 충치균들은 몰래 숨어 있다가 어금니 사이사이 혓바닥 밑에 꼭꼭 숨었어요. 충치균이 입속에서 무슨 일을 하냐고요? 충치균은 어린이 여러분이 음식이나 달콤한 간식을 먹고 이를 닦지 않으면 음식 찌꺼기가 입속에 남아있는 걸 알고 어금니 사이사이 혓바닥 밑에 꼭꼭 숨어 있다가 이에 남아있는 달콤한 음식들을 갉아먹고 이를 콕콕콕 아프게 찌르고 똥을 싸서 까맣게 만들지요. 그렇게 되면 어린이 여러분은 이가 아파 견딜 수가 없어요. 그러면 앞으로 어떻게 해야 충치균들이 여러분의 입속에서 견디지 못할까요? 간단하지요. 충치균이 제일 무서워하는 칫솔과 치약의 도움을 받아 올바른 양치 습관을 실천해서 이를 깨끗하게 하면 되지요. 이 책 마지막 부분에 재미있는 이 닦기가 그림과 함께 잘 표현되어있습니다. 부모님과 함께 따라 해보면 이 닦기를 재미있게 배울 수 있답니다.', 42392.00, '9791188240814', 560, 'https://search.shopping.naver.com/book/catalog/32460426706', 45615.00, '꿈터', 1.9, 'https://shopping-phinf.pstatic.net/main_3246042/32460426706.20221229073103.jpg', 'WAIT', 59, false, false, false, '2020-11-13', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김소선', 9, '사자 삼촌 (책고래마을13, 세종도서 교양부문 선정작)', '아무도 자기 말을 믿어 주지 않아 속상한 아이,
하지만 아이의 말이 정말 사실이라면?
아이들은 때때로 엉뚱한 이야기로 어른들을 깜짝 놀라게 합니다. 꼭 거짓말을 하는 것 같지요. “엄마, 오늘 학교에 코끼리 아저씨가 나타났어!”, “집에 오는데 호랑이가 막 쫓아왔어!” 하고 말이에요. 거짓말이 아니더라도 처음에는 아이의 말을 듣고 놀란 가슴을 쓸어내리던 엄마 아빠들도 자꾸 듣다 보면, 차츰 심드렁해집니다. 적당히 맞장구를 쳐 주고는 말지요. 하지만 아이의 말이 정말 사실이라면 어떨까요?

책고래마을 열세 번째 그림책 『사자삼촌』은 솔이의 ‘사자’ 삼촌 이야기예요. 사자처럼 무서운 삼촌이 아니라 진짜 ‘사자’랍니다. 하지만 아무도 솔이에게 사자삼촌이 있다는 말을 믿어 주지 않았어요. 비웃거나 놀려댈 뿐이었지요. 속상해하는 솔이에게 친구 진이가 다가옵니다. 그리고 둘은 사자삼촌과 함께 신나게 놀아요. 진이가 사자삼촌을 만났다는 이야기를 듣자 아이들도 솔이의 말을 믿기 시작합니다.', 29872.00, '9791187439189', 577, 'https://search.shopping.naver.com/book/catalog/32467342342', 33215.00, '책고래', 4, 'https://shopping-phinf.pstatic.net/main_3246734/32467342342.20221230074926.jpg', 'ON_SALE', 99, false, false, false, '2017-03-31', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김근희', 7, '들꽃이 핍니다 (2014년 환경부 선정 우수환경도서)', '한 땀 한 땀 수를 놓아 담아낸 들꽃 이야기!

『들꽃이 핍니다』는 이름 모르게 피고 지는 들꽃이 어떻게 아름다운 세상을 만들어 가는지 보여주는 그림책이다. 추운 겨울 봄을 기다리는 들꽃부터 작은 아기 잎이 얼굴을 내밀고 자라는 과정을 한 땀 한 땀 정성들여 수 놓았다. 제비꽃, 꽃마리, 뱀딸기, 까마중, 나팔꽃 등 작고 예쁜 꽃들이 피고 지는 모습을 한눈에 볼 수 있고, 개미, 다람쥐, 고슴도치 등 귀여운 동물들도 함께 볼 수 있다. 꽃잎 하나하나 섬세하게 수 놓은 그림들이 생명의 소중함을 다시 한번 느낄 수 있도록 도와준다.', 40340.00, '9788953584105', 981, 'https://search.shopping.naver.com/book/catalog/32492771239', 43580.00, '한솔수북', 3.2, 'https://shopping-phinf.pstatic.net/main_3249277/32492771239.20221227205132.jpg', 'SUSPENSION', 51, false, false, false, '2012-04-25', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김소선', 8, '구름토끼 (책고래마을15, 세종도서 교양부문 선정작)', '구름 위에 토끼가 살고 있다고요? 바닷물을 끓여 구름을 만든다고요?

어릴 적 누구나 한 번쯤 세상에 없는 ‘무엇’에 대해 상상해 본 적이 있을 거예요. 날개가 달린 말, 불을 내뿜는 용, 머리가 여럿 달린 개……. 꼭 눈으로 본 것처럼 신이 나서 이야기하는 아이들에게 어른들은 말하지요. “그런 게 어디 있어?”라고요. 돌아보면, 우리 모두 그런 상상을 하면서 자랐는데 말이에요. 눈에 보이지 않지만 우리 곁에 있는 수많은 것들……. 어쩌면 어른이 된 뒤에는 어릴 적 상상이 깨질까 봐 모른 척 눈 돌리고 있는 건 아닐는지요.

책고래마을 열다섯 번째 그림책 《구름토끼》는 구름 위에 사는 토끼 이야기입니다. 구름토끼들은 신비로운 재주를 가졌어요. 바닷물을 끓여 구름을 만들기도 하고, 일곱 색깔 사탕으로 하늘에 무지개를 띄우기도 해요. 그리고 구름 속에서 빼꼼 고개를 내밀고 우리를 지켜보지요. 김소선 작가는 《사자삼촌》에서 어른들의 선입견을, 《화가와 고양이》에서는 아이들만의 천진난만함을 그려 냈어요. 작가는 세 번째 창작그림책 《구름토끼》를 통해 아이들 마음에 한걸음 더 다가섭니다. 때로는 상처받고, 때로는 아파하는 아이들에게 위로를 건넬 수 있는 ‘구름토끼’가 되어서 말이에요. 구름토끼들 앞에 나타난 한 아이. 아이는 달콤한 사탕을 먹고 있지만 어딘가 외로워 보입니다. 작가는 조심스럽게 아이의 뒤를 쫓습니다. 그리고 아이가 활짝 웃을 수 있도록 특별한 선물을 하지요.

어른들만큼이나 고단하게 하루하루를 살아가는 요즘 아이들에게 구름토끼 같은 친구가 있다면 얼마나 좋을까요? 멀리서 혹은 적당한 거리에서 지켜봐 주고, 힘들어할 땐 눈치 채지 못하게 힘을 북돋아 주는 친구 말이에요. 이야기에서 그랬던 것처럼 《구름토끼》가 우리 아이들에게 웃음을 되찾아 줄 수 있기를 바랍니다.', 35364.00, '9791187439424', 821, 'https://search.shopping.naver.com/book/catalog/32504728767', 39879.00, '책고래', 5, 'https://shopping-phinf.pstatic.net/main_3250472/32504728767.20221227205830.jpg', 'SUSPENSION', 42, false, false, false, '2017-06-28', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('정림', 10, '안녕, 존 (책고래마을1, 세종도서 교양부문 선정작)', '방학을 맞아 할머니 집에 갈 날을 손꼽아 기다리는 아이의 마음이 담긴 맑은 그림책. 아이가 그린 것처럼 크레용으로 쓱쓱 그린 그림과 대비되는 색연필 그림은 두 개의 시선으로 &lt;안녕, 존&gt;을 보게 한다. 베트남 전통 모자를 쓴 할머니의 모습이 나오기 전까지 주인공이 다문화 가정의 아이란 것을 알 수 없다. 친구 \'존\'이 사람이 아니라 베트남에 있는 외갓집 개라는 것도 한 걸음 더 나아가야 알 수 있다.



2050년이면 다문화 인구가 우리나라 전체 인구의 10%에 이른다고 한다. 유럽이나 세계의 다른 여러 나라처럼 우리나라도 이제 다양한 문화의 친구들을 어디서나 쉽게 만날 수 있다. 다문화 가정은 이제 특별한 것이 아니라 다양한 것이다. 겉모습이 나와 다르다는 이유만으로 외톨이가 된 친구들의 마음을 읽어 주기 위해서, 그리고 다른 방식으로 마음을 표현하는 우리 모두를 위해서 만들어졌다.', 10632.00, '9791195590605', 669, 'https://search.shopping.naver.com/book/catalog/32466695951', 11713.00, '책고래', 4.7, 'https://shopping-phinf.pstatic.net/main_3246669/32466695951.20221228073338.jpg', 'CLOSE', 77, false, false, false, '2015-08-21', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이유민', 6, '마음아, 말해봐! (보고, 듣고, 읽고, 생각을 말하고, 쓰는, 정서발달 도서)', '감정의 단어들은 어릴 때부터 자연스럽게 많이 표현할수록 청소년기를 거쳐 성인이 되어서도 속 마음을 상대에게 잘 전달하며 1차적 감정을 올바르게 표현할 수 있도록 도와줄 수 있습니다. 본 도서를 통해, 아이들이 상황에 맞는 1차적 감정 표출을 통해, 표면상으로 감정이 떠오르며 그것을 개방하고 직면하게 되어, 관계의 탐색, 자기성찰의 매개체로서 의사소통능력을 높여 사회성과 자존감을 키워갈 수 있도록 연구하며 제작 된 캐릭터 감정 도서입니다. 1편: 미안해요 고마워요', 16184.00, '9791160032468', 277, 'https://search.shopping.naver.com/book/catalog/32475523998', 18334.00, '창조와지식', 2.5, 'https://shopping-phinf.pstatic.net/main_3247552/32475523998.20221229071450.jpg', 'PROHIBITION', 0, false, false, false, '2020-08-07', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('김성은', 9, '덤벼! (책고래마을10, 세종도서 교양부문 선정작)', '사마귀와 아이의 신나는 한 판 승부!
자연으로 눈을 돌리면 놀 거리가 더 많아요!

책고래마을 열 번째 책 『덤벼!』는 엄마를 따라 외갓집에 온 아이가 사마귀와 신나게 한 판 노는 이야기입니다. 자연과 아이의 특별한 만남을 보여주는 책이지요. 요즘 아이들은 쉽게 사마귀를 볼 기회도 없지만, 생김새가 독특해서 무서워 가까이 가는 게 쉽지 않지요. 그런 사마귀와 아이는 어떻게 놀았을까요? 아이들은 심심한 순간을 견디기 힘들어합니다. 잠시도 가만있지 않고 주위를 살피며 ‘뭐 재미있는 것이 없을까’ 눈을 반짝이지요. 엄마를 붙잡고 조잘조잘 수다를 떨거나 아빠에게 놀아달라고 떼를 쓰기도 합니다. 요즘은 사실 지루할 틈이 없습니다. 텔레비전, 스마트폰, 테블릿 등 눈과 손을 사로잡는 매체들이 너무 많으니까요. 하지만 아이들이 전자기기에 마음을 빼앗기면서 오히려 놀거리는 줄어들었어요. 놀이터에 나가 뛰어놀기보다는 만화영화를 보고, 친구들과 어울리기보다는 게임을 하는 아이들이 훨씬 많지요.', 8481.00, '9791187439073', 585, 'https://search.shopping.naver.com/book/catalog/32456256815', 12883.00, '책고래', 5, 'https://shopping-phinf.pstatic.net/main_3245625/32456256815.20221228073831.jpg', 'CLOSE', 89, false, false, false, '2016-10-21', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('이민희', 3, '아슬아슬 여치가 걸어갑니다 (문화체육관광부 우수도서(세종도서))', '"자연은 자연답게, 아이는 아이답게 내버려 두세요!" 작은 여치가 전하는 커다란 메시지!

이 책은 작은 여치가 어려움을 이겨 내고 성장하는 모습을 재기발랄한 그림과 글로 담아 낸 그림책입니다. 이야기의 주인공 작은 여치는 너무 높고, 너무 좁고, 너무 미끄러운 유리 난간 위를 걸어갑니다. 이 모습을 본 소녀는 아슬아슬하게 유리 난간을 걷고 있는 작은 여치를 도와주기로 합니다. 그리고 커다란 모자를 벗어들고 여치에게 다가갑니다. 하지만 소녀의 커다란 모자 때문에 여치는 큰 위험에 빠집니다. 바둥바둥, 비틀비틀, 허둥지둥! 여치는 커다란 모자를 피해 필사적으로 도망을 칩니다. 소녀가 여치를 돕기 위해 한 행동은 오히려 여치에게는 생명의 위협이 되었지요.

작가는 작은 여치 이야기를 통해 인간의 입장에서 자연을 판단하고 함부로 개입하는 것은 오히려 자연을 해칠 수 있다는 메시지를 전하고자 합니다. 독자들은 자연의 입장에서 바라볼 때, 비로소 자연을 건강하게 지킬 수 있다는 진실을 알게 됩니다. 또 한 가지, 작은 여치는 이제 막 성장을 하는 우리 아이의 모습이기도 합니다. 부모, 혹은 어른의 시선과 잣대로 아이를 가르치는 대신에, 아이의 눈높이에서 아이 스스로 어려움을 이기고 자랄 수 있도록 지켜봐 주어야 한다는 소중한 메시지가 담겨 있습니다.', 35036.00, '9791155714317', 540, 'https://search.shopping.naver.com/book/catalog/32496596638', 37416.00, '상수리', 3.7, 'https://shopping-phinf.pstatic.net/main_3249659/32496596638.20221227205739.jpg', 'OUT_OF_STOCK', 94, false, false, false, '2016-12-05', NOW(), NOW(), null);
INSERT INTO product (author, category_id, title, description, discounted_price, isbn, pages, preview_link, price, publisher, rating, cover_image, status, stock_quantity, is_bestseller, is_hot_new, is_recommend, publish_date, created_at, updated_at, deleted_at) VALUES ('방글', 9, '늙은 배 이야기 (책고래마을5, 세종도서 교양부문 선정작)', '사람의 이야기를 배의 목소리로 들려주고,
독특한 그림으로 보여주는 《늙은 배 이야기》
그러나 단순히 배의 목소리만 들리지 않는 이유는 무얼까요?
《늙은 배 이야기》는 바다를 좋아하는 어느 배의 이야기입니다. 크고 튼튼해서 패기에 넘치던 젊은 시절부터 바다가 두려워지기 시작한 노년까지, 그리고 삶을 마감하는 마지막 순간을 기록하듯 담담하게 《늙은 배 이야기》는 배의 일생을 그려 내고 있습니다. 군더더기 없이 담백하게 서사를 끌고 가는 글과 달리 그림은 다소 어울리지 않는 듯 경쾌한 리듬감을 줍니다. 글을 먼저 읽었을 때와 그림을 먼저 보았을 때의 느낌이 다를 수도 있습니다. 이 불균형한 어울림은 마지막 장면에 이르러서야 비로소 하나의 이야기로 만납니다. 그러나 그 순간, 잠시 숨을 멈출지도 모릅니다. 책장을 덮으면, 가슴 한편에서 전해지는 묵직한 울림이 오래도록 여운으로 남습니다.', 31632.00, '9791195590650', 526, 'https://search.shopping.naver.com/book/catalog/32493367012', 34955.00, '책고래', 4.9, 'https://shopping-phinf.pstatic.net/main_3249336/32493367012.20221227205350.jpg', 'SUSPENSION', 58, false, false, false, '2016-03-03', NOW(), NOW(), null);

INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aegrus', 1, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aestas', 1, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('spectaculum', 1, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ulciscor', 2, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('artificiose', 2, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('depulso', 2, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('sodalitas', 3, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cuius', 3, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vos', 3, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ver', 4, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('voco', 4, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('avaritia', 4, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('calamitas', 5, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('abbas', 5, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('appello', 5, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('victus', 6, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('comedo', 6, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('voluptate', 6, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('terra', 7, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('denego', 7, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('peccatus', 7, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('conculco', 8, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aspernatur', 8, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ait', 8, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cibus', 9, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('expedita', 9, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cognomen', 9, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('verus', 10, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('taceo', 10, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('conturbo', 10, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('demum', 11, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('certe', 11, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('talis', 11, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('celebrer', 12, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('agnitio', 12, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('crinis', 12, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('laboriosam', 13, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('capio', 13, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('defendo', 13, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('spiculum', 14, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('beatae', 14, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('conduco', 14, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('civitas', 15, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('supellex', 15, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('attero', 15, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('amaritudo', 16, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('timor', 16, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('tenetur', 16, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('pauci', 17, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('patruus', 17, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('contra', 17, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vereor', 18, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('decimus', 18, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('adduco', 18, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('alveus', 19, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('alo', 19, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('summisse', 19, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vulgus', 20, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vomer', 20, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('conculco', 20, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('adulatio', 21, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aestus', 21, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('accusantium', 21, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ulterius', 22, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('amplexus', 22, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('advenio', 22, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('enim', 23, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('solium', 23, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('paens', 23, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('coaegresco', 24, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cubo', 24, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ubi', 24, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('certe', 25, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ea', 25, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cerno', 25, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ab', 26, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('similique', 26, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('eius', 26, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('nobis', 27, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('tantum', 27, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('comparo', 27, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('suffoco', 28, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('conduco', 28, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('addo', 28, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('amitto', 29, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('surgo', 29, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ratione', 29, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('pauci', 30, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('rerum', 30, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vilis', 30, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('tubineus', 31, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('fugit', 31, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('attonbitus', 31, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('acquiro', 32, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vapulus', 32, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('pel', 32, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('clibanus', 33, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('statua', 33, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('atrocitas', 33, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('eum', 34, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ea', 34, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aiunt', 34, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('theca', 35, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('suppono', 35, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('canonicus', 35, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aer', 36, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vestigium', 36, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('versus', 36, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('crebro', 37, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('textus', 37, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('spiritus', 37, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('statua', 38, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('nihil', 38, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('a', 38, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('angulus', 39, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('volup', 39, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('suscipio', 39, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('audentia', 40, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('solium', 40, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('a', 40, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('termes', 41, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('deserunt', 41, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('dapifer', 41, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('terminatio', 42, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('thesis', 42, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('veritas', 42, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('accendo', 43, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('fugiat', 43, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('attero', 43, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('varietas', 44, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('delicate', 44, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('adinventitias', 44, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('casus', 45, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('sollers', 45, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('suggero', 45, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('statim', 46, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('repellat', 46, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('denique', 46, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vita', 47, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('corona', 47, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('deprimo', 47, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('adfero', 48, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('accusator', 48, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('arbitro', 48, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('bestia', 49, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('accusamus', 49, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('custodia', 49, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vulpes', 50, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('tandem', 50, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('amplitudo', 50, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('sursum', 51, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('trepide', 51, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('crur', 51, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('conculco', 52, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('clibanus', 52, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('numquam', 52, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('volup', 53, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('animi', 53, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('colligo', 53, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('odit', 54, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('sublime', 54, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('quibusdam', 54, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('curiositas', 55, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('tersus', 55, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('advoco', 55, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vulnero', 56, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vigor', 56, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('tenuis', 56, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('recusandae', 57, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('voro', 57, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('clarus', 57, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('adhaero', 58, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('sponte', 58, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('tero', 58, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('acsi', 59, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('copia', 59, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('arto', 59, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aiunt', 60, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('stipes', 60, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('pel', 60, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('tamen', 61, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('suffoco', 61, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('odio', 61, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ad', 62, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cado', 62, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('illum', 62, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('copia', 63, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('totus', 63, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ullam', 63, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('calamitas', 64, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('deficio', 64, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('urbs', 64, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('tollo', 65, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('odio', 65, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cohaero', 65, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('coerceo', 66, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('validus', 66, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aegrotatio', 66, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('tristis', 67, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vere', 67, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vulnus', 67, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cinis', 68, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('maiores', 68, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('dapifer', 68, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('labore', 69, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('claudeo', 69, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('adduco', 69, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('blandior', 70, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('curatio', 70, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('amor', 70, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aliquid', 71, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ulciscor', 71, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('acerbitas', 71, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('tantum', 72, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('numquam', 72, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('illo', 72, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('comminor', 73, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('conculco', 73, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('rerum', 73, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('adaugeo', 74, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('quibusdam', 74, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('agnosco', 74, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('uter', 75, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('victoria', 75, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('quasi', 75, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('coepi', 76, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cervus', 76, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('strues', 76, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('qui', 77, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('capitulus', 77, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ara', 77, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('credo', 78, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aeger', 78, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('amor', 78, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('texo', 79, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('varietas', 79, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ago', 79, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('colo', 80, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('pel', 80, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('adopto', 80, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aggredior', 81, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cupiditas', 81, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('abscido', 81, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('depereo', 82, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('sulum', 82, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('dolor', 82, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aqua', 83, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('nostrum', 83, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('laboriosam', 83, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('una', 84, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('condico', 84, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vel', 84, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('degero', 85, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('decimus', 85, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('atavus', 85, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('tergeo', 86, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ventus', 86, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('repudiandae', 86, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vesica', 87, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('recusandae', 87, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cultura', 87, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ab', 88, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('id', 88, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ipsam', 88, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('amplus', 89, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('vox', 89, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cerno', 89, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('sollicito', 90, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('amoveo', 90, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aedificium', 90, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('teneo', 91, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('eligendi', 91, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('molestiae', 91, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('angulus', 92, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('caput', 92, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('degenero', 92, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('confido', 93, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('demitto', 93, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('dicta', 93, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('chirographum', 94, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('triumphus', 94, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('crastinus', 94, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aetas', 95, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('torrens', 95, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('trado', 95, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('tardus', 96, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('substantia', 96, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('depulso', 96, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cursim', 97, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('cattus', 97, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('optio', 97, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('porro', 98, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('temporibus', 98, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ultra', 98, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('clarus', 99, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('aeternus', 99, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ipsam', 99, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('ustulo', 100, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('celebrer', 100, NOW(), NOW());
INSERT INTO product_tag (name, product_id, created_at, updated_at) VALUES ('auxilium', 100, NOW(), NOW());
