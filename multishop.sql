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

--sequence
drop sequence upCategory_seq;
create sequence upCategory_seq nocache;

drop sequence downCategory_seq;
create sequence downCategory_seq nocache;

drop sequence product_seq;
create sequence product_seq nocache;

insert into upCategory values(upCategory_seq.nextval, '컴퓨터.디지털.가전');
insert into upCategory values(upCategory_seq.nextval, '패션의류.잡화.뷰티');
commit;

select * from upCategory;

insert into downCategory(upcg_code, downcg_code, downcg_name)
values(1, downCategory_seq.nextval, '노트북');
insert into downCategory(upcg_code, downcg_code, downcg_name)
values(1, downCategory_seq.nextval, '모니터');
insert into downCategory(upcg_code, downcg_code, downcg_name)
values(1, downCategory_seq.nextval, '주방가전');

insert into downCategory(upcg_code, downcg_code, downcg_name)
values(2, downCategory_seq.nextval, '여성의류');
insert into downCategory(upcg_code, downcg_code, downcg_name)
values(2, downCategory_seq.nextval, '남성의류');
commit;
select * from downCategory;


select * from product;





