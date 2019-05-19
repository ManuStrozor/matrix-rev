with P_Math; use P_Math;

package P_String is
   
   subtype T_Str is String(1..20);
   
   -- Fractions --
   function Num(Str : in String) return Integer;
   function Denum(Str : in String) return Integer;
   function Slash(Str : in String) return Integer;
   function Simp(I1, I2 : in Integer) return String;
   
   -- Calcul --
   function Divide(N, D : in String) return T_Str;
   function Floaty(Str : in String) return Float;
   
   -- Traitement string --
   function Trim(S : in String) return String;
   function Oppose(S : in String) return String;
   function Strlen(Str : in String) return Integer;
   
end;
