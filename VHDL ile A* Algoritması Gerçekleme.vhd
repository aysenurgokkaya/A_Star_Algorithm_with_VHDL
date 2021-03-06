library ieee;	--kütüphane ve paketler
use ieee.std_logic_1164.all;	
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity astaralgorithm is	--1 bitlik saat girişli entity tanımı
port(s:in std_logic);
end entity;

architecture behv of astaralgorithm is	--mimari tanımı
type matrix is array (0 to 8) of integer;	--baslangıç dizisi
signal A: matrix := (2,4,3,1,8,5,7,0,6);	--değer ataması
signal C: matrix; 
begin -- mimari
	process(s)
	 variable p1, p2, p3, p4:integer:=100;	--Haraket ağırlığı değişkenleri
	 variable  ft, tmp:integer :=0;			--eşik değeri ve swap için temp değişkeni
	 variable s1, s2, s3, s4: integer:=0;
	 variable x: integer:=7;
	 variable i,m,j: integer:=0;
	 variable B: matrix := A;
	begin
		if(rising_edge(s)) then --basla
         if (  x+1 <= 8 ) then 
			p1:=0;
			tmp := B(x+1); -- işaretçiyi 1 ileri kaydır
			B(x+1):=B(x);
			B(x) := tmp; 
			for i in 0 to 8 loop		--p1 ağırlığını hesapla
				if(B(i)-i -1 <= 2) then
					if (( B(i)-i -1)=1 or (B(i)-i -1)=-1) then
						p1 := p1+1;
					end if;
				if (( B(i)-i -1)=2 or (B(i)-i -1)=-2) then
					p1 := p1+2;
				end if;
				end if;
				if(B(i)-i-1 > 2) then
				if (( B(i)-i -1)=3 or (B(i)-i -1)=-3) then
						p1 := p1+1;
				end if;
				if (( B(i)-i -1)=4 or (B(i)-i -1)=-4) then
				p1 := p1+2;
				end if;
		    end if;
		   end loop;
	       tmp := B(x);	--işaretçiyi eski pozisyonuna getir
           B(x):=B(x+1);
           B(x+1) := tmp;
		end if;
		 if (  x+3 <= 8 ) then 	--kotrol 8den küçük mü --girmez
			p3:=0;
			tmp := B(x+3);
			B(x+3):=B(x);
			B(x) := tmp;
			for i in 0 to 8 loop
				if(B(i)-i -1 <= 2) then
					if (( B(i)-i -1)=1 or (B(i)-i -1)=-1) then
						p3:= p3+1;
					end if;
					if (( B(i)-i -1)=2 or (B(i)-i -1)=-2) then
						p3 := p3+2;
					end if;
				end if;
				if(B(i)-i-1 > 2) then
					if (( B(i)-i -1)=3 or (B(i)-i -1)=-3) then
						p3 := p3+1;
					end if;
					if (( B(i)-i -1)=4 or (B(i)-i -1)=-4) then
					p3 := p3+2;
					end if;
				end if;
		   end loop;
		   tmp := B(x);
           B(x):=B(x+3);
           B(x+3) := tmp;
		end if;
		 if ( not( x-1 <= 0) ) then 
			p2:=0;
			tmp := B(x-1);
			B(x-1) := B(x);
			B(x) := tmp;
			for i in 0 to 8 loop
				if(B(i)-i -1 <= 2) then
					if (( B(i)-i -1)=1 or (B(i)-i -1)=-1) then
						p2 := p2+1;
					end if;
					if (( B(i)-i -1)=2 or (B(i)-i -1)=-2) then
						p2 := p2+2;
					end if;
				end if;
				if(B(i)-i-1 > 2) then
					if (( B(i)-i -1)=3 or (B(i)-i -1)=-3) then
						p2 := p2+1;
					end if;
					if (( B(i)-i -1)=4 or (B(i)-i -1)=-4) then
						p2 := p2+2;
					end if;
				end if;
		   end loop;
		   tmp := B(x); --swap orjinal
		   B(x):=B(x-1);
           B(x-1) := tmp;
		end if;
		 if ( not( x-3 <= 0) ) then	-- 3 ç?kar
			p4:=0;
            tmp := B(x-3);
            B(x-3) := B(x);
            B(x) := tmp;
			for i in 0 to 8 loop
				if(B(i)-i -1 <= 2) then
					if (( B(i)-i -1)=1 or (B(i)-i -1)=-1) then
						p4 := p4+1;
					end if;
					if (( B(i)-i -1)=2 or (B(i)-i -1)=-2) then
						p4 := p4+2;
					end if;
				end if;
				if(B(i)-i-1 > 2) then
					if (( B(i)-i -1)=3 or (B(i)-i -1)=-3) then
						p4 := p4+1;
					end if;
					if (( B(i)-i -1)=4 or (B(i)-i -1)=-4) then
						p4 := p4+2;
					end if;
				end if;
			end loop;
            tmp := B(x); --swap orjinal
            B(x):=B(x-3);
            B(x-3) := tmp;
         end if;
		 report "p1 : " & integer'image (p1); -- +1
		 report "p2 : " & integer'image (p2); -- -1
		 report "p3 : " & integer'image (p3); -- +3
		 report "p4 : " & integer'image (p4); -- -3
		 if (p1 <= p2 and p1 <= p3 and p1 <= p4 and not(s1=-1)) then 
			if (ft>p1 or ft=p1 ) then	
				tmp := B(x+1);
				B(x+1):=B(x);
				B(x) := tmp;
				x :=x+1;
				ft:=p1;
			    report "esik degeri : " & integer'image (ft);--ft bas
				m:=1;
				s1:=0; s2:=0; s3:=0; s4:=0;
				end if;
			if ft<p1 then
				if j=0 then
					ft:=p1;
					report "esik degeri : " & integer'image (ft);--ft bas
					j:=j+1;
					tmp := B(x+1);
					B(x+1):=B(x);
					B(x) := tmp;
				else 
					j:=j-1;
					s1:=-1; 
					tmp := B(x);
					B(x):=B(x-m);
					B(x-m):= tmp;
				end if;
			end if;
        end if;
		 if (p2 <= p1 and p2 <= p3 and p2 <= p4 and not(s2=-1)) then
			if (ft>p2 or ft=p2) then	
				tmp := B(x-1);
                B(x-1):=B(x);
                B(x) := tmp;
            	x :=x-1;
				ft:=p2;
	            report "esik degeri : " & integer'image (ft);--ft bas
				m:=-1;
				s1:=0; s2:=0; s3:=0; s4:=0;
		    end if;
			if ft<p2 then
				if j=0 then
					ft := p2;
					report "esik degeri : " & integer'image (ft);--ft bas
					j:=j+1;
					tmp := B(x-1);
					B(x-1):= B(x);
					B(x) := tmp;
					x := x-1;
				else 
					j:=j-1;
					s2:=-1; 
					tmp := B(x);
					B(x):= B(x-m);
					B(x-m) := tmp;
				end if;
            end if;
		end if;
		 if (p3 <= p1 and p3 <= p2 and p3 <= p4 and not(s3=-1)) then
                  if (ft>p3 or ft=p3) then	
					 tmp := B(x+3);
                     B(x+3):=B(x);
                     B(x) := tmp;
                     x :=x+3;
					 ft:=p3;
		             report "esik degeri : " & integer'image (ft);--ft bas
					 m:=3;
					 s1:=0; s2:=0; s3:=0; s4:=0;
		           end if;
		   if ft<p3 then
		    if i=0 then
		     ft:=p3;
		     j:=j+1;
		     tmp := B(x+3);
                     B(x+3):=B(x);
                     B(x) := tmp;
		   else 
		    j:=j-1;
		    s3:=-1; 
		    tmp := B(x);
                    B(x):=B(x-m);
                    B(x-m):= tmp;
		  end if;
         end if;
		end if;
		 if (p4 <= p1 and p4 <= p2 and p4 <=p3 and not (s4=-1)) then
            if (ft>p4 or ft=p4 ) then	
				tmp := B(x-3);
				B(x-3):=B(x);
				B(x) := tmp;
				x :=x-3;
				ft:=p4;
				report "esik degeri : " & integer'image (ft);--ft bas
				m:=-3;
				s1:=0; s2:=0; s3:=0; s4:=0;
			end if;
			if ft<p4 then
				if j=0 then
				ft:=p4;
				j:=j+1;
				tmp := B(x-3);
				B(x-3):=B(x);
				B(x) := tmp;
				x:=x-3;
				report "esik degeri : " & integer'image (ft);--ft bas
			else 
				j:=j-1;
				s4:=-1; 
				tmp := B(x);
				B(x):=B(x-m);
				B(x-m):= tmp;
				x:=x-m;
			end if;
        end if;
		end if;
        C <= B;
		end if;
	end process;
end behv;

		
			

----------------------------------------------------------------------------------------------------------


--Do scirpt komutları
--vsim -gui work.astaralgorithm
--add wave -position insertpoint sim:/astaralgorithm/*
--force -freeze sim:/astaralgorithm/s 0 0, 1 {50 ps} -r 100
--run

