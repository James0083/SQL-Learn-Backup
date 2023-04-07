DESC MEMO;
SELECT * FROM MEMO;

--일련번호를 생성하는 객체 - SEQUENCE

--CREATE SEQUENCE 시퀀스명
--START WITH 시작수
--INCREMENT BY 증가값
--[그 외 옵션]

CREATE SEQUENCE MEMO_SEQ
START WITH 3
INCREMENT BY 1;
-- 시뭔스의 속성
-- NEXTVAL : 다음에 증가할 값을 반환
-- CURRVAL : 현재 가지고 있는 값을 반환
--    [주의] CURRVAL의 경우는 NEXTVAL이 호출된 후에 사용할 수 있다

INSERT INTO MEMO(NO, NAME, MSG)
VALUES(MEMO_SEQ.NEXTVAL, '김철수', '반갑습니다');
COMMIT;
SELECT * FROM MEMO;

SELECT MEMO_SEQ.CURRVAL FROM DUAL;


update memo set name='이영희' where no=2;
select * from memo;
commit;

select * from emp;
delete from emp where empno=8000;
commit;

--2023-04-05
select * from memo order by 1 desc;

--2023-04-06
SELECT * FROM MEMO ORDER BY 1 DESC;
SELECT COUNT(*) FROM MEMO;






