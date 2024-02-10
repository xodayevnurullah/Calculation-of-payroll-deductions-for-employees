SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION emek_haqqi_function
(
    sektor NUMBER, --1 q/neft ve ozel--2 neft ve dovlet
    emek_haqqi NUMBER,    
    guzest NUMBER    
)
RETURN NUMBER
IS 
    nett_emek_haqqi NUMBER;
    gelir_vergisi NUMBER;
    sosial_sigorta NUMBER;
    ishsizlikden_sigorta NUMBER;
    icbari_tibbi_sigorta NUMBER;
    vergiye_celb_olunan_mebleg NUMBER;

BEGIN     
    DBMS_OUTPUT.PUT_LINE ('Hesablanmis ayliq emekhaqqi (GROSS): '||emek_haqqi);
    
IF emek_haqqi < 345 THEN DBMS_OUTPUT.PUT_LINE ('Duzgun daxil edilmeyib. Emek haqqi 345 manatdan az ola bilmez!') ;
ELSE
        IF sektor =1 
         THEN
           IF emek_haqqi <=8000
            THEN 
                 IF guzest =1
                THEN                                     
                    vergiye_celb_olunan_mebleg := emek_haqqi;
                    gelir_vergisi := (vergiye_celb_olunan_mebleg)*0 ;                  
                ELSIF guzest =102.2
                THEN                    
                    IF emek_haqqi <=400
                    THEN
                    vergiye_celb_olunan_mebleg := 0; 
                    gelir_vergisi :=0;
                    ELSE
                    vergiye_celb_olunan_mebleg := emek_haqqi-400;
                    gelir_vergisi := (vergiye_celb_olunan_mebleg)*0;
                    END IF;
                ELSIF guzest =102.3
                THEN
                    IF emek_haqqi <=200
                    THEN
                    vergiye_celb_olunan_mebleg := 0; 
                    gelir_vergisi :=0;
                    ELSE
                    vergiye_celb_olunan_mebleg := emek_haqqi-200;
                    gelir_vergisi := (vergiye_celb_olunan_mebleg)*0;
                    END IF;
                ELSIF guzest =102.4
                THEN
                    IF emek_haqqi <=100
                    THEN
                    vergiye_celb_olunan_mebleg := 0; 
                    gelir_vergisi :=0;
                    ELSE
                    vergiye_celb_olunan_mebleg := emek_haqqi-100;
                    gelir_vergisi := (vergiye_celb_olunan_mebleg)*0;
                    END IF;
                ELSIF guzest =102.5
                THEN
                     IF emek_haqqi <=50
                    THEN
                    vergiye_celb_olunan_mebleg := 0; 
                    gelir_vergisi :=0;
                    ELSE
                    vergiye_celb_olunan_mebleg := emek_haqqi-50;
                    gelir_vergisi := (vergiye_celb_olunan_mebleg)*0;
                    END IF;
            END IF;   
                IF emek_haqqi <=200
                THEN
                sosial_sigorta := emek_haqqi*0.03;
                ELSE                                
                sosial_sigorta := (200*0.03)+(emek_haqqi-200)*0.1;  
                END IF;
            ishsizlikden_sigorta := emek_haqqi*0.005;               
            icbari_tibbi_sigorta := emek_haqqi*0.02;
            nett_emek_haqqi := emek_haqqi-(gelir_vergisi+ 
                                     sosial_sigorta+
                                     ishsizlikden_sigorta+
                                     icbari_tibbi_sigorta);
            ELSIF emek_haqqi >8000
            THEN
                IF guzest =1
                THEN
                vergiye_celb_olunan_mebleg := emek_haqqi;
                gelir_vergisi := (vergiye_celb_olunan_mebleg-8000)*0.14 ;
                ELSIF guzest =102.2
                THEN
                vergiye_celb_olunan_mebleg :=emek_haqqi-400;
                     IF vergiye_celb_olunan_mebleg <8000
                        THEN
                        gelir_vergisi := 0;
                        ELSE
                        gelir_vergisi := (vergiye_celb_olunan_mebleg-8000)*0.14 ;
                        END IF;
                ELSIF guzest =102.3
                THEN
                vergiye_celb_olunan_mebleg :=emek_haqqi-200;
                     IF vergiye_celb_olunan_mebleg <8000
                        THEN
                        gelir_vergisi := 0;
                        ELSE
                        gelir_vergisi := (vergiye_celb_olunan_mebleg-8000)*0.14 ;
                        END IF;
                ELSIF guzest =102.4
                THEN
                vergiye_celb_olunan_mebleg :=emek_haqqi-100;
                     IF vergiye_celb_olunan_mebleg <8000
                        THEN
                        gelir_vergisi := 0;
                        ELSE
                        gelir_vergisi := (vergiye_celb_olunan_mebleg-8000)*0.14 ;
                        END IF;
                ELSIF guzest =102.5
                THEN
                vergiye_celb_olunan_mebleg :=emek_haqqi-50;
                        IF vergiye_celb_olunan_mebleg <8000
                        THEN
                        gelir_vergisi := 0;
                        ELSE
                        gelir_vergisi := (vergiye_celb_olunan_mebleg-8000)*0.14 ;
                        END IF;
                END IF;
            sosial_sigorta := (200*0.03)+(emek_haqqi-200)*0.1;
            ishsizlikden_sigorta := emek_haqqi*0.005;               
            icbari_tibbi_sigorta := 8000*0.02+(emek_haqqi-8000)*0.005;
            nett_emek_haqqi := emek_haqqi-(gelir_vergisi+ 
                                     sosial_sigorta+
                                     ishsizlikden_sigorta+
                                     icbari_tibbi_sigorta);            
            END IF;
        ELSIF sektor=2 
         THEN
           IF emek_haqqi <=2500
            THEN
                IF guzest =1
                THEN
                    IF emek_haqqi between 0 and 200
                    THEN                    
                    vergiye_celb_olunan_mebleg := emek_haqqi;
                    gelir_vergisi :=0 ;
                    ELSE                   
                    vergiye_celb_olunan_mebleg := emek_haqqi;
                    gelir_vergisi := (vergiye_celb_olunan_mebleg-200)*0.14 ;
                    END IF;                
                ELSIF guzest =102.2
                THEN                    
                     IF emek_haqqi between 0 and 600
                     THEN
                        IF emek_haqqi <=400
                        THEN
                        vergiye_celb_olunan_mebleg := 0;
                        ELSE
                        vergiye_celb_olunan_mebleg := emek_haqqi-400;
                        END IF;
                    gelir_vergisi := 0;
                    ELSE
                    vergiye_celb_olunan_mebleg := emek_haqqi-400;
                    gelir_vergisi := (vergiye_celb_olunan_mebleg-200)*0.14;
                    END IF;
                ELSIF guzest =102.3
                THEN
                    IF emek_haqqi between 0 and 400
                    THEN
                        IF emek_haqqi <=200
                        THEN
                        vergiye_celb_olunan_mebleg := 0;
                        ELSE
                        vergiye_celb_olunan_mebleg := emek_haqqi-200;
                        END IF;
                    gelir_vergisi := 0;
                    ELSE
                    vergiye_celb_olunan_mebleg := emek_haqqi-200;
                    gelir_vergisi := (vergiye_celb_olunan_mebleg-200)*0.14;
                    END IF;
                ELSIF guzest =102.4
                THEN
                    IF emek_haqqi between 0 and 300
                    THEN
                        IF emek_haqqi <=100
                        THEN
                        vergiye_celb_olunan_mebleg := 0;
                        ELSE
                        vergiye_celb_olunan_mebleg := emek_haqqi-100;
                        END IF;
                    gelir_vergisi := 0;
                    ELSE
                    vergiye_celb_olunan_mebleg := emek_haqqi-100;
                    gelir_vergisi := (vergiye_celb_olunan_mebleg-200)*0.14;
                    END IF;
                ELSIF guzest =102.5
                THEN
                     IF emek_haqqi between 0 and 250
                    THEN
                        IF emek_haqqi <=50
                        THEN
                        vergiye_celb_olunan_mebleg := 0;
                        ELSE
                        vergiye_celb_olunan_mebleg := emek_haqqi-50;
                        END IF;
                    gelir_vergisi := 0;
                    ELSE
                    vergiye_celb_olunan_mebleg := emek_haqqi-50;
                    gelir_vergisi := (vergiye_celb_olunan_mebleg-200)*0.14;
                    END IF;
                END IF;           
            sosial_sigorta := emek_haqqi*0.03;
            ishsizlikden_sigorta := emek_haqqi*0.005;               
            icbari_tibbi_sigorta := emek_haqqi*0.02;
            nett_emek_haqqi := emek_haqqi-(gelir_vergisi+ 
                                     sosial_sigorta+
                                     ishsizlikden_sigorta+
                                     icbari_tibbi_sigorta);            
            ELSIF emek_haqqi >2500
            THEN
                IF guzest =1
                THEN
                vergiye_celb_olunan_mebleg := emek_haqqi;
                gelir_vergisi := 2500*0.14+(vergiye_celb_olunan_mebleg-2500)*0.25 ;
                ELSIF guzest =102.2
                THEN
                vergiye_celb_olunan_mebleg :=emek_haqqi-400;
                        IF vergiye_celb_olunan_mebleg <2500
                        THEN
                        gelir_vergisi := (vergiye_celb_olunan_mebleg)*0.14;
                        ELSE
                        gelir_vergisi := 2500*0.14+(vergiye_celb_olunan_mebleg-2500)*0.25  ;
                        END IF;
                ELSIF guzest =102.3
                THEN
                vergiye_celb_olunan_mebleg :=emek_haqqi-200;
                        IF vergiye_celb_olunan_mebleg <2500
                        THEN
                        gelir_vergisi := (vergiye_celb_olunan_mebleg)*0.14;
                        ELSE
                        gelir_vergisi := 2500*0.14+(vergiye_celb_olunan_mebleg-2500)*0.25  ;
                        END IF;
                ELSIF guzest =102.4
                THEN
                vergiye_celb_olunan_mebleg :=emek_haqqi-100;
                        IF vergiye_celb_olunan_mebleg <2500
                        THEN
                        gelir_vergisi := (vergiye_celb_olunan_mebleg)*0.14;
                        ELSE
                        gelir_vergisi := 2500*0.14+(vergiye_celb_olunan_mebleg-2500)*0.25  ;
                        END IF;
                ELSIF guzest =102.5
                THEN
                vergiye_celb_olunan_mebleg :=emek_haqqi-50;
                        IF vergiye_celb_olunan_mebleg <2500
                        THEN
                        gelir_vergisi := (vergiye_celb_olunan_mebleg)*0.14;
                        ELSE
                        gelir_vergisi := 2500*0.14+(vergiye_celb_olunan_mebleg-2500)*0.25  ;
                        END IF;
                END IF;
            sosial_sigorta := emek_haqqi*0.03;
            ishsizlikden_sigorta := emek_haqqi*0.005; 
            
                IF emek_haqqi >=8000
                 THEN            
                    icbari_tibbi_sigorta := 8000*0.02+(emek_haqqi-8000)*0.005;
                ELSE
                    icbari_tibbi_sigorta := emek_haqqi*0.02;
                END IF;
                
            nett_emek_haqqi := emek_haqqi-(gelir_vergisi+ 
                                     sosial_sigorta+
                                     ishsizlikden_sigorta+
                                     icbari_tibbi_sigorta);           
           END IF;
        
      END IF;  
        DBMS_OUTPUT.PUT_LINE ('Vergiye celb olunan mebleg: '||vergiye_celb_olunan_mebleg);
        DBMS_OUTPUT.PUT_LINE ('Gelir vergisi: '|| round(gelir_vergisi,2));
        DBMS_OUTPUT.PUT_LINE ('DSMF ayirmalari: '||round(sosial_sigorta,2));
        DBMS_OUTPUT.PUT_LINE ('Ishsizlikden sigorta haqqi: '||round(ishsizlikden_sigorta,2));
        DBMS_OUTPUT.PUT_LINE ('Icbari tibbi sigorta haqqi: '||round(icbari_tibbi_sigorta,2));
        DBMS_OUTPUT.PUT_LINE ('NETT emekhaqqi: '||round(emek_haqqi,2));
  END IF;
    RETURN nett_emek_haqqi;
    
  END;
/

select emek_haqqi_function(2,878,102.3) from dual;
