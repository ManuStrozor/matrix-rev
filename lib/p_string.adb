package body P_String is
   
   -- Fractions --
   
   function Num(Str : in String) return Integer is
   begin
      if Slash(Str) /= Str'Last+1 then
	 return Integer'Value(Str(Str'First..Slash(Str)-1));
      else
	 return Integer'Value(Str);
      end if;
   end;
      
   function Denum(Str : in String) return Integer is
   begin
      if Slash(Str) /= Str'Last+1 then
	 return Integer'Value(Str(Slash(Str)+1..Str'Last));
      else
	 return 1;
      end if;
   end;
   
   function Slash(Str : in String) return Integer is
      I : Integer := Str'first;
   begin
      while I <= Str'last and then Str(I) /= '/' loop
	 I := I + 1;
      end loop;
      return I;
   end;
   
   function Simp(I1, I2 : in Integer) return String is
      N, D : Integer;
      P : Integer := Pgcd(I1, I2);
   begin
      N := Integer(Float(I1) / Float(P));
      D := Integer(Float(I2) / Float(P));
      declare
	 ImageD : String := Integer'Image(D);
      begin
	 if D /= 1 then
	    return Integer'Image(N) & '/' & ImageD(ImageD'First+1..ImageD'Last);
	 else
	    return Integer'Image(N);
	 end if;
      end;
   end;
   
   -- Calcul --
   
   function Divide(N, D : in String) return T_Str is
      Res : Float := Floaty(N) / Floaty(D);
      S1 : String := Integer'Image(Num(N) * Denum(D));
      S2 : String := Integer'Image(Denum(N) * Num(D));
      Coef1 : String := Integer'Image(Integer(Res));
      Coef2 : String := Simp(Integer'Value(S1), Integer'Value(S2));
   begin
      declare
	 Tmp1 : String(1..T_Str'Length-Coef1'length) := (others => ' ');
	 Tmp2 : String(1..T_Str'Length-Coef2'length) := (others => ' ');
      begin
	 if Isint(Res) then
	    return Coef1 & Tmp1;
	 else
	    return Coef2 & Tmp2;
	 end if;
      end;
   end;
   
   function Floaty(Str : in String) return Float is
   begin
      return Float(Num(Str)) / Float(Denum(Str));
   end;
   
   -- Traitement string --
   
   function Trim(S : in String) return String is
      I : Integer := S'First;
      Cnt : Integer := 0;
   begin
      while S(I) = ' ' loop
	 Cnt := Cnt + 1;
	 I := I + 1;
      end loop;
      return S(S'First+Cnt..Strlen(S));
   end;
   
   function Oppose(S : in String) return String is
   begin
      if S(S'First) = ' ' then
	 return '-' & S(S'First+1..S'Last);
      else
	 return ' ' & S(S'First+1..S'Last);
      end if;
   end;
   
   function Strlen(Str : in String) return Integer is
      I : Integer := str'First+1;
      Len : Integer := 0;
   begin
      while I <= str'Last and then str(I) /= ' ' loop
	 Len := Len + 1;
	 I := I + 1;
      end loop;
      return Len+1;
   end;
   
end;
