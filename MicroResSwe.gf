resource MicroResSwe = open Prelude in {

param
  Number = Sg | Pl ;
  Species = Indef | Def ;
  Case = Nom | Acc ;
  Gender = Utr | Neutr ; -- Utr是common gender/utrum,"en"，Neutr是neuter gender/neutrum,"ett"

  --NGSAgreement = NGSAgr Gender Number Species; -- used e.g. for noun-adj agreement

  VForm = Inf | PresSg3 | Past | Supine  ; -- ignore past participle (passive) and imperative, present participle, and infinitive with "att"


oper

 -- Noun declension
  N : Type = {s : Number => Species => Str ; g : Gender} ;
  --PN : Type = {s : Str};

  --mkPN : Str -> PN
    --= \s -> {s = s} ;

  worstN : Str -> Str -> Str -> Str -> Gender -> N
    = \man,mannen,män,männen,g -> {
      s = table {
        Sg => table {Indef => man ; Def => mannen} ;
	      Pl => table {Indef => män ; Def => männen}
	      } ;
      g = g
      } ;
-- https://en.wikipedia.org/wiki/Swedish_grammar


  -- gf的lambda语法：\param -> expr
  decl1 : Str -> N
    = \apa ->
      let ap = init apa in
      worstN (ap + "a") (ap + "an") (ap + "or") (ap + "orna") Utr ;

  decl2 : Str -> N
    = \bil -> case bil of {
      _ => worstN bil (bil + "en") (bil + "ar") (bil + "arna") Utr
      } ;

  decl3 : Str -> N
    = \armé -> case armé of {
      _ => worstN armé (armé + "n") (armé + "er") (armé + "erna") Utr
      } ;

  decl4 : Str -> N
    = \barn -> case barn of {
      _ => worstN barn (barn + "et") barn (barn + "en") Neutr 
      } ;

  decl5 : Str -> N
    = \äpple -> case äpple of {
      _ => worstN äpple (äpple + "t") (äpple + "n") (äpple + "na") Neutr
      } ;

  decl6 : Str -> N
    = \katt -> case katt of {
      _ => worstN katt (katt + "en") (katt + "er") (katt + "erna") Utr
      } ;


 -- Adjective declension
  A : Type = {s : Gender => Number => Species => Str ;} ;  -- case is not yet involed in MicroLang so we ignore the case

  mkAdjective : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> A
    = \usg_d,nsg_d,upl_d,npl_d,usg_id,nsg_id,upl_id,npl_id -> {
      s = table {
        Utr => table {Sg => table {Indef => usg_id ; Def => usg_d} ; 
                      Pl => table {Indef => upl_id ; Def => upl_d}} ;
        Neutr => table {Sg => table {Indef => nsg_id ; Def => usg_d} ; 
                      Pl => table {Indef => upl_id ; Def => upl_d}} 
        }
      } ;
  smartAdjective : Str -> A = \s -> case s of {
    _ => mkAdjective (s + "a") (s + "a") (s + "a") (s + "a") s (s + "t") (s + "a") (s + "a") 
    } ;

  mkA_t :  Str -> A = \s -> case s of {
    _ => mkAdjective (s + "a") (s + "a") (s + "a") (s + "a") s s (s + "a") (s + "a") 
    } ;

  mkA_vowel :  Str -> A = \s -> case s of {
    _ => mkAdjective (s + "a") (s + "a") (s + "a") (s + "a") s (s + "tt") (s + "a") (s + "a") 
    } ;

  mkA_same :  Str -> A = \s -> case s of {
    _ => mkAdjective s s s s s s s s
    } ;

  mkA = overload { 
    mkA : Str -> A = smartAdjective ;
    mkA : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> A = mkAdjective
    } ;


  
--  Adverb
  Adv : Type = {s : Str} ;

  mkAdv : Str -> Adv
    = \s -> {s = s} ;


-- Verb
  V : Type = {s : VForm => Str};

  mkVerb : Str -> Str -> Str -> Str -> V
    = \inf,pres,past,supine -> {
    s = table {
      Inf => inf ;
      PresSg3 => pres ;
      Past => past ;
      Supine => supine 
      }
    } ;

  regVerb : (inf : Str) -> V =\inf ->
    mkVerb inf (inf + "r") (inf + "de") (inf + "t") ;

  -- two-place verb with "case" as preposition; for transitive verbs, c=[]
  V2 : Type = V ** {c : Str} ;
  --V : Type = {s : VForm => Str};

  mkV2 : V -> Str -> V2
   = \v, c -> {
    s = v.s ;
    c = c
    } ;

  mkAdv : Str -> Adv
    = \s -> {s = s} ;

  be_Verb : V = mkVerb "vara" "är" "var" "varit" ;

  



}