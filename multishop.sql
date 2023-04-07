DROP INDEX PK_upCategory;

/* 상위 카테고리 */
DROP TABLE upCategory 
	CASCADE CONSTRAINTS;

/* 상위 카테고리 */
CREATE TABLE upCategory (
	upcg_code number(8) NOT NULL, /* 상위 카테고리 코드 */
	upcg_name varchar2(30) NOT NULL /* 상위 카테고리명 */
);

COMMENT ON TABLE upCategory IS '상위 카테고리';

COMMENT ON COLUMN upCategory.upcg_code IS '상위 카테고리 코드';

COMMENT ON COLUMN upCategory.upcg_name IS '상위 카테고리명';

CREATE UNIQUE INDEX PK_upCategory
	ON upCategory (
		upcg_code ASC
	);

ALTER TABLE upCategory
	ADD
		CONSTRAINT PK_upCategory
		PRIMARY KEY (
			upcg_code
		);
------------------------------------------
DROP INDEX PK_downCategory;

/* 하위 카테고리 */
DROP TABLE downCategory 
	CASCADE CONSTRAINTS;

/* 하위 카테고리 */
CREATE TABLE downCategory (
	upcg_code number(8) NOT NULL, /* 상위 카테고리 코드 */
	downcg_code number(8) NOT NULL, /* 하위 카테고리 코드 */
	downcg_name varchar2(30) NOT NULL /* 하위 카테고리명 */
);

COMMENT ON TABLE downCategory IS '하위 카테고리';

COMMENT ON COLUMN downCategory.upcg_code IS '상위 카테고리 코드';

COMMENT ON COLUMN downCategory.downcg_code IS '하위 카테고리 코드';

COMMENT ON COLUMN downCategory.downcg_name IS '하위 카테고리명';

CREATE UNIQUE INDEX PK_downCategory
	ON downCategory (
		upcg_code ASC,
		downcg_code ASC
	);

ALTER TABLE downCategory
	ADD
		CONSTRAINT PK_downCategory
		PRIMARY KEY (
			upcg_code,
			downcg_code
		);

ALTER TABLE downCategory
	ADD
		CONSTRAINT FK_upCategory_TO_downCategory
		FOREIGN KEY (
			upcg_code
		)
		REFERENCES upCategory (
			upcg_code
		);
-------------------------------------------------
DROP INDEX PK_product;

/* 상품 */
DROP TABLE product 
	CASCADE CONSTRAINTS;

/* 상품 */
CREATE TABLE product (
	pnum number(8) NOT NULL, /* 상품번호 */
	pname varchar2(100) NOT NULL, /* 상품명 */
	price number(8) NOT NULL, /* 상품 정가 */
	salprice number(8), /* 상품 판매가 */
	pcompany varchar2(50), /* 제조사 */
	pcontents varchar2(1000), /* 상품 설명 */
	pspec varchar2(20), /* 상품 스펙 */
	point number(8), /* 포인트 */
	pindate date, /* 상품 입고일 */
	pimage1 varchar2(100), /* 이미지1 */
	pimage2 varchar2(100), /* 이미지2 */
	pimage3 varchar2(100), /* 이미지3 */
	upcg_code number(8), /* 상위 카테고리 코드 */
	downcg_code number(8) /* 하위 카테고리 코드 */
);

COMMENT ON TABLE product IS '상품';

COMMENT ON COLUMN product.pnum IS '상품번호';

COMMENT ON COLUMN product.pname IS '상품명';

COMMENT ON COLUMN product.price IS '상품 정가';

COMMENT ON COLUMN product.salprice IS '상품 판매가';

COMMENT ON COLUMN product.pcompany IS '제조사';

COMMENT ON COLUMN product.pcontents IS '상품 설명';

COMMENT ON COLUMN product.pspec IS '상품 스펙';

COMMENT ON COLUMN product.point IS '포인트';

COMMENT ON COLUMN product.pindate IS '상품 입고일';

COMMENT ON COLUMN product.pimage1 IS '이미지1';

COMMENT ON COLUMN product.pimage2 IS '이미지2';

COMMENT ON COLUMN product.pimage3 IS '이미지3';

COMMENT ON COLUMN product.upcg_code IS '상위 카테고리 코드';

COMMENT ON COLUMN product.downcg_code IS '하위 카테고리 코드';

CREATE UNIQUE INDEX PK_product
	ON product (
		pnum ASC
	);

ALTER TABLE product
	ADD
		CONSTRAINT PK_product
		PRIMARY KEY (
			pnum
		);

ALTER TABLE product
	ADD
		CONSTRAINT FK_downCategory_TO_product
		FOREIGN KEY (
			upcg_code,
			downcg_code
		)
		REFERENCES downCategory (
			upcg_code,
			downcg_code
		);

ALTER TABLE product
	ADD
		CONSTRAINT FK_upCategory_TO_product
		FOREIGN KEY (
			upcg_code
		)
		REFERENCES upCategory (
			upcg_code
		);
------------------------------------------------------------
DROP INDEX PK_member;

/* 회원 */
DROP TABLE member 
	CASCADE CONSTRAINTS;

/* 회원 */
CREATE TABLE member (
	idx number(8) NOT NULL, /* 회원번호 */
	name varchar2(30) NOT NULL, /* 이름 */
	userid varchar2(20) NOT NULL, /* 아이디 */
	pwd varchar2(100) NOT NULL, /* 비밀번호 */
	hp1 char(3) NOT NULL, /* 연락처1 */
	hp2 char(4) NOT NULL, /* 연락처2 */
	hp3 char(4) NOT NULL, /* 연락처3 */
	post char(5), /* 우편번호 */
	addr1 varchar2(100), /* 주소1 */
	addr2 varchar2(100), /* 주소2 */
	indate DATE, /* 가입일 */
	mileage number(8), /* 보유적립금 */
	mstate number(2), /* 회원상태 */
	mreason varchar2(100) /* 정지, 탈퇴사유 */
);

COMMENT ON TABLE member IS '회원';

COMMENT ON COLUMN member.idx IS '회원번호';

COMMENT ON COLUMN member.name IS '이름';

COMMENT ON COLUMN member.userid IS '아이디';

COMMENT ON COLUMN member.pwd IS '비밀번호';

COMMENT ON COLUMN member.hp1 IS '연락처1';

COMMENT ON COLUMN member.hp2 IS '연락처2';

COMMENT ON COLUMN member.hp3 IS '연락처3';

COMMENT ON COLUMN member.post IS '우편번호';

COMMENT ON COLUMN member.addr1 IS '주소1';

COMMENT ON COLUMN member.addr2 IS '주소2';

COMMENT ON COLUMN member.indate IS '가입일';

COMMENT ON COLUMN member.mileage IS '보유적립금';

COMMENT ON COLUMN member.mstate IS '회원상태';

COMMENT ON COLUMN member.mreason IS '정지, 탈퇴사유';

CREATE UNIQUE INDEX PK_member
	ON member (
		idx ASC
	);

ALTER TABLE member
	ADD
		CONSTRAINT PK_member
		PRIMARY KEY (
			idx
		);
        
drop sequence member_seq;

create sequence member_seq
start with 1
increment by 1
nocache;

desc member;