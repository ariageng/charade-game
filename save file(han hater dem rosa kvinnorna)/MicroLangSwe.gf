--# -path=.:../abstract

concrete MicroLangSwe of MicroLang = open MicroResSwe in {

lincat 
 -- Common
  Utt = {s : Str} ;

 -- Cat
  S = {s : Str} ;
  VP = {s : Str } ;
  AP = MicroResSwe.A ;
  SubAPNP = {s : Str ; n : Number ; g : Gender } ;
  ObjAPNP = {s : Str ; n : Number ; g : Gender } ;
  CN = MicroResSwe.N ;
  NP = {s : Str ; n : Number ; g : Gender } ;
  Det = {s : Gender => Str ; n : Number; sp : Species};
  ADet = {s : Gender => Str ; n : Number; sp : Species};
  Prep = {s : Str};
  V = MicroResSwe.V ;
  --V : Type = {s : VForm => Str};
  V2 = MicroResSwe.V2 ;
  A = MicroResSwe.A ;
  --A : Type = {s : Gender => Number => Species => Str ;} ;  -- case is not yet involed in MicroLang so we ignore the case
  N = MicroResSwe.N ;
  --N : Type = {s : Number => Species => Str ; g : Gender} ;
  Pron = {s : Case => Str ; n : Number} ;
  Adv = {s : Str} ;
  NomP = {s : Str} ;
  PronNom = {s : Str} ;
  PronAcc = {s : Str} ;
  --Adv : Type = {s : Str} ;
  

  
  

lin 
 -- syntax part 
  UttS s = s;
  UttNP np = np ;

 -- e.g. (abstract) PredVPS   : NP -> VP -> S ;   
  PredVPS np vp = {s = np.s  ++ vp.s } ;
  PronVPS nomp vp = {s = nomp.s ++ vp.s} ;
  CompAPS np ap = {s = np.s ++ be_Verb.s ! PresSg3 ++ ap.s ! np.g ! np.n ! Indef } ;
  ApNPAPS subapnp ap = {s = subapnp.s ++ be_Verb.s ! PresSg3 ++ ap.s ! subapnp.g ! subapnp.n ! Indef } ;        -- De roliga pojkarna är galen
  ApNPVPS subapnp vp = {s = subapnp.s ++ vp.s} ;        -- De roliga pojkarna hatar honom

  UseV v = {s = v.s ! PresSg3 ; n = Sg} ;

  ComplV2 v2 np = {s = v2.s ! PresSg3 ++ np.s} ;
  ComplV2AP v2  objapnp = {s = v2.s ! PresSg3 ++ objapnp.s } ;

  AdvVP vp adv =
      {s = vp.s ++ adv.s } ;

  TheDetPlCN cn = {
      s = cn.s ! Pl ! Def ;
      n = Pl ;
      sp = Def ;
      g = cn.g
      } ;

  TheDetSgCN cn = {
      s = cn.s ! Sg ! Def ;
      n = Sg ;
      sp = Def ;
      g = cn.g
      } ;

  ADetCN adet cn = {
      s = adet.s ! cn.g ++ cn.s ! Sg ! Indef ;
      n = Sg ;
      sp = Indef;
      g = cn.g
      };

  PlCN cn = {
      s = cn.s ! Pl ! Indef ;
      n = Pl ;
      sp = Indef ;
      g = cn.g
      };

  NomPron p = {s= p.s ! Nom } ;       -- she

  UseNomPron p = {s = p.s } ;   -- she

  AccPron p = {s= p.s ! Acc } ;       -- her

  a_Det = {
    s = table { Utr => "en" ; Neutr => "ett"};
    n = Sg;
    sp = Indef
    } ; 

  --aPl_Det = {
    --s = table { _ => "" };
    --n = Pl;
    --sp = Indef
    --} ; 

  the_Det = {
    s = table { Utr => "den" ; Neutr => "det"};
    n = Sg;
    sp = Def
    } ; 

  thePl_Det = {
    s = table { Utr => "de" ; Neutr => "de"};
    n = Pl;
    sp = Def
    } ; 

  UseN n = n ;

  AdjSgDefNP ap cn = {
    s = the_Det.s ! cn.g ++ ap.s ! cn.g ! Sg ! Def ++ cn.s ! Sg ! Def;
    g = cn.g ;
    n = Sg 
    } ;

  AdjPlDefSubNP ap cn = {
    s = thePl_Det.s ! cn.g ++ ap.s ! cn.g ! Pl ! Def ++ cn.s ! Pl ! Def;
    g = cn.g ;
    n = Pl 
    } ;

  AdjPlDefObjNP ap cn = {
    s = "dem" ++ ap.s ! cn.g ! Pl ! Def ++ cn.s ! Pl ! Def;
    g = cn.g ;
    n = Pl 
    } ;


  PositA a = a ;

  PrepNP prep np = {s = prep.s ++ np.s } ;
  PrepNom prep pronAcc = {s = prep.s ++ pronAcc.s} ;

  in_Prep = {s = "i"} ;
  on_Prep = {s = "på"} ;
  with_Prep = {s = "med"} ;

  he_Pron = {
    s = table {Nom => "han" ; Acc => "honom"} ;
    n = Sg ;
    } ;
  she_Pron = {
    s = table {Nom => "hon" ; Acc => "henne"} ;
    n = Sg ;
    } ;
  they_Pron = {
    s = table {Nom => "de" ; Acc => "dem"} ;
    n = Pl ;
    } ;


 -- lexical part
    already_Adv = mkAdv "redan" ;
    animal_N = decl4 "djur" ;
    apple_N = decl5 "äpple" ;
    baby_N = decl2 "bebis" ;
    bad_A = mkA "dålig" ;
    beer_N = decl4 "öl";
    big_A = mkA "stor" ;
    bike_N = worstN "cykel" "cykeln" "cyklar" "cyklarna" Utr ;
    bird_N = worstN "fågel" "fågeln" "fåglar" "fåglarna" Utr ;
    black_A = mkA_t "svart";
    blood_N = worstN "blod" "blodet" "bloder" "bloden" Neutr ;
    blue_A = mkA_vowel "blå" ;
    boat_N = decl2 "båt" ;
    book_N = worstN "bok" "boken" "böcker" "böckerna" Utr ;
    boy_N = worstN "pojke" "pojken" "pojkar" "pojkarna" Utr ;
    bread_N = decl4 "bröd" ;
    break_V2 = mkV2 (mkVerb "bryta" "bryter" "bröt" "brutit") "";
    buy_V2 = mkV2 (mkVerb "köpa" "köper" "köpte" "köpt") "" ;
    car_N = decl2 "bil" ;
    cat_N = decl6 "katt" ;
    child_N = decl4 "barn" ;
    city_N = worstN "stad" "staden" "städer" "städerna" Utr ;
    clean_A = mkA "ren" ;
    clever_A = mkA_t "smart" ;
    cloud_N = decl4 "moln" ;
    cold_A = mkA "kall" ;
    come_V = mkVerb "komma" "kommer" "kom" "kommit";
    computer_N = decl3 "dator" ;
    cow_N = worstN "ko" "kon" "kor" "korna" Utr ;
    dirty_A = mkA "smutsig" ;
    dog_N = decl2 "hund" ;
    drink_V2 = mkV2 (mkVerb "dricka" "dricker" "drack" "druckit") "" ;
    eat_V2 =mkV2 (mkVerb "äta" "äter" "åt" "ätit") "" ;
    find_V2 = mkV2 (mkVerb "finna" "finner" "fann" "funnit") "" ;
    fire_N = decl2 "eld" ;
    fish_N = decl2 "fisk" ;
    flower_N = decl1 "blomma" ;
    friend_N = worstN "vän" "vännen" "vänner" "vännerna" Utr ;
    girl_N = decl1 "flicka" ;
    good_A = mkA_same "bra" ;
    go_V = mkVerb "gå" "går" "gick" "gått" ;
    grammar_N = decl6 "grammatik" ;
    green_A = mkA "grön" ;
    heavy_A = mkA "tung" ;
    horse_N = decl2 "häst" ;
    hot_A = mkA "het" ;
    house_N = decl4 "hus" ;
    --john_PN = mkPN "John" ;
    jump_V = regVerb "hoppa" ;
    kill_V2 = mkV2 (regVerb "döda") "" ;
    --know_VS = mkVerb "veta" "vet" "visste" "vetat" ;
    language_N = decl4 "språk" ;
    live_V = mkVerb "leva" "lever" "levde" "levt" ;
    love_V2 = mkV2 (regVerb "älska") "" ;
    man_N = worstN "man" "mannen" "män" "männen" Utr ;
    milk_N = decl2 "mjölk" ;
    music_N = decl6 "musik" ;
    new_A = mkA_vowel "ny" ;
    now_Adv = mkAdv "nu" ;
    old_A = mkAdjective "gamla" "gamla" "gamla" "gamla" "gammal" "gammalt" "gamla" "gamla" ;
    --paris_PN = mkPN "Paris" ;
    play_V = regVerb "spela" ;
    read_V2 = mkV2 (mkVerb "läsa" "läser" "läste" "läst") "" ;
    ready_A = mkA_same "redo" ;
    red_A = mkAdjective "röda" "röda" "röda" "röda" "röd" "rött" "röda" "röda";
    river_N = decl6 "flod" ;
    run_V = mkVerb "springa" "springer" "sprang" "sprungit";
    sea_N = decl4 "hav" ;
    see_V2 = mkV2 (mkVerb "se" "ser" "såg" "sett") "" ;
    ship_N = decl4 "skepp" ;
    sleep_V = mkVerb "sova" "sover" "sov" "sovit";
    small_A = mkAdjective "lilla" "lilla" "små" "små" "liten" "litet" "små" "små" ;
    star_N = decl1 "stjärna" ;
    swim_V = regVerb "simma" ;
    teach_V2 = mkV2 (regVerb "undervisa") "" ;
    train_N = decl4 "tåg" ;
    travel_V = mkVerb "resa" "reser" "reste" "rest" ;
    tree_N = decl4 "träd" ;
    understand_V2 = mkV2 (mkVerb "förstå" "förstår" "förstod" "förstått") "" ;
    wait_V2 = mkV2 (regVerb "vänta") "på" ;
    walk_V = mkVerb "gå" "går" "gick" "gått" ;
    warm_A = mkA "varm" ;
    water_N = worstN "vatten" "vattnet" "vatten" "vattnen" Neutr;
    white_A = mkA "vit" ;
    wine_N = worstN "vin" "vinet" "viner" "vinerna" Neutr ;
    woman_N = decl1 "kvinna" ;
    yellow_A = mkA "gul" ;
    young_A = mkA "ung" ;
    
    

}