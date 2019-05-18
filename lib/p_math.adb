package body P_Math is
   
   function Min(A, B : in Integer) return Integer is
   begin
      if A < B then
	 return A;
      else
	 return B;
      end if;
   end;
   
   function Isint(F : in Float) return Boolean is
   begin
      return F = Float(Integer(F));
   end;
   
   function Pgcd(A, B : in Integer) return Integer is
      C : Integer;
   begin
      C := A mod B;
      if C = 0 then
	 return B;
      else
	 return Pgcd(B,C);
      end if;
   end;
   
end;
