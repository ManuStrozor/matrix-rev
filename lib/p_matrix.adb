package body P_Matrix is
   
   function Triinf(Mat : in TV_Str) return Boolean is
      J : Positive;
   begin
      for I in Mat'Range(1) loop
	 J := I+1;
	 while J <= Mat'Length(2) loop
	    if Floaty(Mat(I, J)) /= 0.0 then return False; end if;
	    J := J + 1;
	 end loop;
      end loop;
      return True;
   end;
   
   function Trisup(Mat : in TV_Str) return Boolean is
      J : Positive;
   begin
      for I in Mat'Range(1) loop
	 J := 1;
	 while J < I loop
	    if Floaty(Mat(I, J)) /= 0.0 then return False; end if;
	    J := J + 1;
	 end loop;
      end loop;
      return True;
   end;
   
   function RDiago(Mat : in TV_Str) return Boolean is
   begin
      for I in 1..Mat'Length(1) loop
	 if Floaty(Mat(I, I)) = 0.0 then
	    return False;
	 end if;	    
      end loop;
      return True;
   end;
   
   function Diago(Mat : in TV_Str) return Boolean is
   begin
      for I in 1..Mat'Length(1) loop
	 if Floaty(Mat(I, I)) = 0.0 and not LVide(Mat, I) then
	    return False;
	 end if;	    
      end loop;
      return True;
   end;
   
   function LVide(Mat : in TV_Str; L : in positive) return Boolean is
   begin
      for I in 1..Mat'last(2) loop
	 if Floaty(Mat(L, I)) /= 0.0 then return False; end if;
      end loop;
      return True;
   end;
   
   function Max(Mat : in TV_Str) return Integer is
      Max, N : Integer;
   begin
      Max := 2;
      for I in Mat'Range(1) loop
	 for J in Mat'Range(2) loop
	    N := Strlen(Trim(Mat(I, J)));
	    if N > Max then Max := N; end if;
	 end loop;
      end loop;
      return Max;
   end;
   
   procedure Switch_L(Mat, Uni : out TV_Str; L1, L2 : in Positive) is
      Tmp : T_Str;
   begin
      for I in Mat'Range(2) loop
	 Tmp := Mat(L1, I);
	 Mat(L1, I) := Mat(L2, I);
	 Mat(L2, I) := Tmp;
	 Tmp := Uni(L1, I);
	 Uni(L1, I) := Uni(L2, I);
	 Uni(L2, I) := Tmp;
      end loop;
   end;
   
   procedure Switch_C(Mat : out TV_Str; C1, C2 : in Positive) is
      Tmp_I : T_Str;
   begin
      for I in Mat'Range(1) loop
	 Tmp_I := Mat(I, C1);
	 Mat(I, C1) := Mat(I, C2);
	 Mat(I, C2) := Tmp_I;
      end loop;
   end;
   
   procedure CalcStr(Cible : out T_Str; Pivot, Coef : in String) is
      M : String := Simp(Num(Coef) * Num(Pivot), Denum(Coef) * Denum(Pivot));
      C : String := Simp((Num(Cible) * Denum(M)) - (Num(M) * Denum(Cible)), Denum(Cible) * Denum(M));
   begin
      declare
	 Tmp : String(1..T_Str'Length-C'Length) := (others => ' ');
      begin
	 Cible := C & Tmp;
      end;
   end;
   
   procedure GetCand(Mat, Uni : out TV_Str; Piv : in Positive) is
      Switched : Boolean := False;
      I : Integer := Piv;
   begin
      while I <= Mat'Last(1) and not switched loop
	 if I /= Piv and Floaty(Mat(I, piv)) /= 0.0 then
	    Switch_L(Mat, Uni, Piv, I);
	    Switched := True;
	 end if;
	 I := I + 1;
      end loop;
      I := Piv;
      while I <= Mat'Last(2) and not switched loop
	 if I /= Piv and Floaty(Mat(piv, I)) /= 0.0 then
	    Switch_C(Mat, Piv, I);
	    Switched := True;
	 end if;
	 I := I + 1;
      end loop;
      A_La_Ligne;
      Affiche(Mat, Uni);
   end;
   
   procedure UpPivot(Mat, Uni : out TV_Str; Piv : in positive) is
      Coef : T_Str;
      Useless : Boolean := True;
   begin
      A_La_Ligne;
      for I in reverse 1..Piv loop
	 if I /= Piv and Floaty(Mat(I, Piv)) /= 0.0 then
	    Coef := Divide(Mat(I, Piv), Mat(Piv, Piv));
	    for J in Piv..Mat'Last(2) loop
	       CalcStr(Mat(I, J), Mat(Piv, J), Coef);
	    end loop;
	    for J in 1..Uni'Last(2) loop
	       CalcStr(Uni(I, J), Uni(Piv, J), Coef);
	    end loop;
	    AfficheEtapes(Coef, I, Piv);
	    Useless := False;
	 end if;
      end loop;
      if not Useless then
	 A_La_Ligne;
	 Affiche(Mat, Uni);
      end if;
   end;
   
   procedure DoPivot(Mat, Uni : out TV_Str; Piv : in positive) is
      Coef : T_Str;
      Useless : Boolean := True;
   begin
      A_La_Ligne;
      for I in Piv..Mat'last(1) loop
	 if I /= Piv and Floaty(Mat(I, Piv)) /= 0.0 then
	    Coef := Divide(Mat(I, Piv), Mat(Piv, Piv));
	    for J in Piv..Mat'Last(2) loop
	       CalcStr(Mat(I, J), Mat(Piv, J), Coef);
	    end loop;
	    for J in 1..Uni'Last(2) loop
	       CalcStr(Uni(I, J), Uni(Piv, J), Coef);
	    end loop;
	    AfficheEtapes(Coef, I, Piv);
	    Useless := False;
	 end if;
      end loop;
      if not Useless then
	 A_La_Ligne;
	 Affiche(Mat, Uni);
      end if;
   end;
   
   procedure DiagToOne(Mat, Uni : out TV_Str) is
      Tmp : T_Str;
   begin
      for I in 1..Mat'Length(2) loop
	 Tmp := Mat(I, I);
	 for J in 1..Mat'Length(1) loop
	    Mat(I, J) := Divide(Mat(I, J), Tmp);
	    Uni(I, J) := Divide(Uni(I, J), Tmp);
	 end loop;
      end loop;
      A_La_Ligne;
      Affiche(Mat, Uni);
   end;
   
   procedure Calcul(Mat, Uni : out TV_Str) is
      I : Integer;
   begin
      A_La_Ligne;
      Ecrire_Ligne("Matrice de départ :");
      Affiche(Mat);
      A_La_Ligne;
      Affiche(Mat, Uni);
      
      I := 1;
      while I <= Mat'Length(2) and then not (Trisup(Mat) and Diago(Mat)) loop
	 if Floaty(Mat(I, I)) = 0.0 then
	    GetCand(Mat, Uni, I);
	    DoPivot(Mat, Uni, I);
	 else
	    DoPivot(Mat, Uni, I);
	 end if;
	 I := I + 1;
      end loop;
      
      if not RDiago(Mat) then
	 A_La_Ligne;
	 Ecrire_Ligne("La matrice n'est pas inversible !");
      else
	 DiagToOne(Mat, Uni);
	 
	 I := Mat'Length(2);
	 while I >= 1 and not Triinf(Mat) loop
	    UpPivot(Mat, Uni, I);
	    I := I - 1;
	 end loop;
	 
	 A_La_Ligne;
	 Ecrire_Ligne("Matrice inverse :");
	 Affiche(Uni);
      end if;
   end;
   
   procedure Dimension(N : out Positive) is
   begin
      loop
	 Ecrire("Dimension de la matrice carré : "); Lire(N);
	 exit when N > 0;
      end loop;
   end;
   
   procedure Lire(Mat : out TV_Str) is
   begin
      for I in Mat'Range(1) loop
	 for J in Mat'Range(2) loop
	    Ecrire("Coef" & Image(I) & Image(J) & " : "); Lire(Mat(I, J));
	 end loop;
      end loop;
   end;
   
   procedure AfficheEtapes(Coef : in String; I, Piv : in positive) is
      Coeff : String := Oppose(Coef);
   begin
      if Floaty(Coef) > 0.0 then
	 if Floaty(Coef) = 1.0 then
	    Ecrire_Ligne("* L" & Trim(Image(I)) & " <- L" & Trim(Image(I)) & " - L" & Trim(Image(Piv)));
	 else
	    Ecrire_Ligne("* L" & Trim(Image(I)) & " <- L" & Trim(Image(I)) & " - " & Trim(Coef) & " L" & Trim(Image(Piv)));
	 end if;
      else
	 if Floaty(Coeff) = 1.0 then
	    Ecrire_Ligne("* L" & Trim(Image(I)) & " <- L" & Trim(Image(I)) & " + L" & Trim(Image(Piv)));
	 else
	    Ecrire_Ligne("* L" & Trim(Image(I)) & " <- L" & Trim(Image(I)) & " + " & Trim(Coeff) & " L" & Trim(Image(Piv)));
	 end if;
      end if;
   end;
      
   procedure Affiche(Mat, Uni : in TV_Str) is
      MMaxS, UMaxS, Diff : Integer;
   begin
      MMaxS := Max(Mat);
      UMaxS := Max(Uni);
      for I in Mat'Range(1) loop
	 for J in Mat'Range(2) loop
	    
	    Diff := MMaxS - Strlen(Trim(Mat(I, J)));
	    for S in 1..Diff loop
	       Ecrire(' ');
	    end loop;
	    
	    Ecrire(Trim(Mat(I, J)));
	    
	    if J /= Mat'Last(2) then
	       Ecrire(' ');
	    else
	       Ecrire(" |");
	    end if;
	    
	 end loop;
	 for J in Uni'Range(2) loop
	    
	    Diff := UMaxS - Strlen(Trim(Uni(I, J)));
	    for S in 1..Diff loop
	       Ecrire(' ');
	    end loop;
	    
	    Ecrire(Trim(Uni(I, J)));
	    
	    if J /= Uni'Last(2) then
	       Ecrire(' ');
	    end if;
	    
	 end loop;
	 if I /= Uni'Last(1) then A_La_Ligne; end if;
      end loop;
      A_La_Ligne;
   end;
   
   procedure Affiche(Mat : in TV_Str) is
      MaxS, Diff : Integer;
   begin
      MaxS := Max(Mat);
      for I in Mat'Range(1) loop
	 for J in Mat'Range(2) loop
	    
	    Diff := MaxS - Strlen(Trim(Mat(I, J)));
	    for S in 1..Diff loop
	       Ecrire(' ');
	    end loop;
	    
	    Ecrire(Trim(Mat(I, J)));
	    
	    if J /= Mat'Last(2) then
	       Ecrire(' ');
	    end if;
	    
	 end loop;
	 if I /= Mat'Last(1) then A_La_Ligne; end if;
      end loop;
      A_La_Ligne;
   end;
   
end;
