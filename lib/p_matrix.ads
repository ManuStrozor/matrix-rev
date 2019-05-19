with P_Esiut; use P_Esiut;
with P_String; use P_String;
with P_Math; use P_Math;

package P_Matrix is
   
   type TV_Str is array(Integer range <>, Integer range <>) of T_Str;
   
   function Triinf(Mat : in TV_Str) return Boolean;
   function Trisup(Mat : in TV_Str) return Boolean;
   function RDiago(Mat : in TV_Str) return Boolean;
   function Diago(Mat : in TV_Str) return Boolean;
   function LVide(Mat : in TV_Str; L : in positive) return Boolean;
   function Max(Mat : in TV_Str) return Integer;
   
   procedure Switch_L(Mat, Uni : out TV_Str; L1, L2 : in Positive);
   procedure Switch_C(Mat : out TV_Str; C1, C2 : in Positive);
   procedure CalcStr(Cible : out T_Str; Pivot, Coef : in String);
   procedure GetCand(Mat, Uni : out TV_Str; Piv : in Positive);
   procedure UpPivot(Mat, Uni : out TV_Str; Piv : in positive);
   procedure DoPivot(Mat, Uni : out TV_Str; Piv : in positive);
   procedure DiagToOne(Mat, Uni : out TV_Str);
   procedure Calcul(Mat, Uni : out TV_Str);
   
   procedure Dimension(N : out Positive);
   procedure Lire(Mat : out TV_Str);
   procedure AfficheEtapes(Coef : in String; I, Piv : in positive);
   procedure Affiche(Mat, Uni : in TV_Str);
   procedure Affiche(Mat : in TV_Str);
   
end;
