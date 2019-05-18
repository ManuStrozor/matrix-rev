with P_Esiut; use P_Esiut;
with P_Matrix; use P_Matrix;

procedure Matrixrev is
   N : Positive;
begin
   Dimension(N);
   A_La_Ligne;
   declare
      M, U : TV_Str(1..N, 1..N);
   begin
      Lire(M);
      for I in 1..N loop
	 for J in 1..N loop
	    if I = J then
	       U(I, J) := " 1                  ";
	    else
	       U(I, J) := " 0                  ";
	    end if;
	 end loop;
      end loop;
      A_La_Ligne;
      Affiche(M, U);
      Calcul(M, U);
      A_La_Ligne;
      Affiche(M, U);
   end;
end;
