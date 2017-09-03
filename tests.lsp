;


(defun IS (A B N)
  (cond
    ((equal A B) t)
    (t (format t "~%FAILED ~A~%<<<GOT      ~A~%>>>EXPECTED ~A~%" N A B))))

(defun IS_NOT (A B N)
  (cond
    ((not (equal A B)) t)
    (t (format t "~%FAILED ~A~%<<<GOT      ~A~%>>>EXPECTED ~A~%"  N))))

(defun TEST_UTILS ()
  (load "utils.lsp")
  (print "UTILS TESTING")
  (IS '(a b) '(a b) "test of test1")
  (IS '(a (a b)) '(a (a b)) "test of test3")
  (IS '(a (a b) (a) b) '(a (a b) (a) b) "test of test4")
  (IS_NOT '(a b) '(a c) "test of test5")
  (IS_NOT '(a (a b) (a) b) '(a (a b) () b) "test of test6")

  (IS (head 'a) 'a "head test1")
  (IS (head '(a)) 'a "head test2")
  (IS (head '()) nil "head test3")
  (IS (head '((a b) b)) '(a b) "head test4")

  (IS (tail 'a) nil "tail test1")
  (IS (tail '(a b)) '(b) "tail test2")
  (IS (tail '(a (a b))) '((a b)) "tail test3")
  (IS (tail '(a)) nil "tail test4")

  (IS (len '()) 0 "len test1")
  (IS (len '(a)) 1 "len test2")
  (IS (len '(a b)) 2 "len test3")
  (IS (len '(a () (b a b))) 3 "len test4")

  (IS (take 2 '()) nil "take test1")
  (IS (take 7 '(a b c d e f g)) 'g "take test2")
  (IS (take 0 '(a b c)) nil "take test3")
  (IS (take 1 '(() a)) '() "take test4")
  (IS (take -1 '(a b)) nil "take test5")
  (IS (take 2 '((a b) (b c))) '(b c) "take test6")

  (IS (drop 0 '(a b)) '(a b) "drop test1")
  (IS (drop 1 '(a b c)) '(b c) "drop test2")
  (IS (drop 2 '((a b) (a ()) (a b) b)) '((a b) b) "drop test3")

  (IS (mylist 'a) '(a) "mylist test1")
  (IS (mylist '()) nil "mylist test2")
  (IS (mylist '(a)) '(a) "mylist test3")
  (IS (mylist '(a b)) '(a b) "mylist test4")

  (IS (is_in 'a '()) nil "is_in test1")
  (IS (is_in 'a '(a)) t "is_in test2")
  (IS (is_in 'a '(a b)) t "is_in test3")
  (IS (is_in 'a '(b a)) t "is_in test4")
  (IS (is_in 'c '(b a)) nil "is_in test5")
  (IS (is_in '(! a) '(b (! a))) t "is_in test6")
  (IS (is_in '(! a) '(b (! c))) nil "is_in test7")

  (IS (merge_sets '() '()) '() "merge_sets test1")
  (IS (merge_sets '(a) '()) '(a) "merge_sets test2")
  (IS (merge_sets '() '(b)) '(b) "merge_sets test3")
  (IS (merge_sets '(a) '(b)) '(a b) "merge_sets test4")
  (IS (merge_sets '(a b) '(b)) '(a b) "merge_sets test5")
  (IS (merge_sets '(a b) '(c)) '(a b c) "merge_sets test6")
  (IS (merge_sets '((! a) b) '(a)) '((! a) b a) "merge_sets test7")
  (IS (merge_sets '((! a) b) '((! a))) '((! a) b) "merge_sets test8")
  (IS (merge_sets '((! a) b (! c) c d) '(b (! b) (! c) d)) '((! a) b (! c) c d (! b)) "merge_sets test9")

  (print "DONE TESTING"))

(defun TEST_FORMULA ()
  (load "formula.lsp")
  (print "TESTING FORMULA")
  (IS (IsNeg ()) nil "IsNeg test1")
  (IS (IsNeg '1) nil "IsNeg test2")
  (IS (IsNeg '!) t "IsNeg test3")

  (IS (DropNegatives '(a)) '(a) "DropNeg test1")
  (IS (DropNegatives '(a b)) '(a b) "DropNeg test2")
  (IS (DropNegatives '()) '() "DropNeg test3")
  (IS (DropNegatives '(! ! a)) '(a) "DropNeg test4")
  (IS (DropNegatives '(! a)) '(! a) "DropNeg test5")
  (IS (DropNegatives '(! ! ! a)) '(! a) "DropNeg test6")
  (IS (DropNegatives '(! ! ! a ! b ! ! c)) '(! a ! b c) "DropNeg test7")
  (IS (DropNegatives '(! ! (! a) ! b ! ! c)) '((! a) ! b c) "DropNeg test8")
  (IS (DropNegatives '(! ! (! a) ((! b)) ! ! c)) '((! a) ((! b)) c) "DropNeg test9")
  (IS (DropNegatives '(! ! ! ! ! ! ! !)) '() "DropNeg test10")
  (IS (DropNegatives '(((! ! a)) b c ! ! a)) '(((a)) b c a) "DropNeg test11")

  (IS (TakeNegatives '()) '() "TakeNegatives test1")
  (IS (TakeNegatives '(a)) '(a) "TakeNegatives test2")
  (IS (TakeNegatives '((a))) '((a)) "TakeNegatives test3")
  (IS (TakeNegatives '((! a))) '(((! a))) "TakeNegatives test4")
  (IS (TakeNegatives '(a b)) '(a b) "TakeNegatives test5")
  (IS (TakeNegatives '(! a b)) '((! a) b) "TakeNegatives test6")
  (IS (TakeNegatives '((((! a b))))) '(((((! a) b)))) "TakeNegatives test7")
  (IS (TakeNegatives '((((! a b)) c) ! d)) '(((((! a) b)) c) (! d)) "TakeNegatives test8")
  (IS (TakeNegatives '((((! a b)) c f ! g) ! d)) '(((((! a) b)) c f (! g)) (! d)) "TakeNegatives test9")

  (IS (FormLevel '() '*) nil "FormLevel test1")
  (IS (FormLevel '(a) '*) '(a) "FormLevel test2")
  (IS (FormLevel '(a * b) '*) '((a * b)) "FormLevel test3")
  (IS (FormLevel '(a + b * c) '*) '(a + (b * c)) "FormLevel test4")
  (IS (FormLevel '(a * b * c) '*) '(((a * b) * c)) "FormLevel test5")
  (IS (FormLevel '(1 + a * b * c) '*) '(1 + ((a * b) * c)) "FormLevel test6")
  (IS (FormLevel '(1 + a * (b + 0) * c) '*) '(1 + ((a * (b + 0)) * c)) "FormLevel test7")
  (IS (FormLevel '(1 + (((! a))) * (b + 0) * c) '*) '(1 + (((((! a))) * (b + 0)) * c)) "FormLevel test8")
  (print "DONE TESTING"))

(defun TEST_DEMORGAN ()
  (load "demorgan.lsp")
  (print "START DEMORGAN TESTING")

  (IS (DropImplic '(a > b)) '((! a) + b) "DropImplic test1")
  (IS (DropImplic '(a > (b * c))) '((! a) + (b * c)) "DropImplic test2")
  (IS (DropImplic '(a > (b > c))) '((! a) + ((! b) + c)) "DropImplic test3")
  (IS (DropImplic '((((a > b))))) '((! a) + b) "DropImplic test4")

  (IS (DropMorgans '()) '() "DropMorgans test1")
  (IS (DropMorgans '(a)) '(a) "DropMorgans test2")
  (IS (DropMorgans '(a + b)) '(a + b) "DropMorgans test3")
  (IS (DropMorgans '(a + (! b))) '(a + (! b)) "DropMorgans test4")
  (IS (DropMorgans '((! a) + (! b))) '((! a) + (! b)) "DropMorgans test5")
  (IS (DropMorgans '(! (a + b))) '((! a) * (! b)) "DropMorgans test6")
  (IS (DropMorgans '(! (a * b))) '((! a) + (! b)) "DropMorgans test7")
  (IS (DropMorgans '(! (! (a * b)))) '(a * b) "DropMorgans test8")
  (IS (DropMorgans '(1 * (! (! (a * b))))) '(1 * (a * b)) "DropMorgans test9")
  (IS (DropMorgans '(1 + (! (a + (! (b + c)))))) '(1 + ((! a) * (b + c))) "DropMorgans test10")
  (IS (DropMorgans '(1 + (! (a + (b + c))))) '(1 + ((! a) * ((! b) * (! c)))) "DropMorgans test11")
  (print "DONE TESTING"))

(defun TEST_DNF ()
  (load "dnf.lsp")
  (print "START DNF TESTING")

  (IS (IsElCon '(e_c a b)) t "e_c test1")

  (IS (IsSimple '()) t "IsSimple test1")
  (IS (IsSimple 'a) t "IsSimple test2")
  (IS (IsSimple '(! a)) t "IsSimple test3")
  (IS (IsSimple '((! a) + b)) nil "IsSimple test4")
  (IS (IsSimple '(a + b)) nil "IsSimple test5")

  (IS (_makeElCon 'a) '(e_c a) "_makeElCon test1")
  (IS (_makeElCon '(! a)) '(e_c (! a)) "_makeElCon test2")
  (IS (_makeElCon '(a * b)) '(e_c a b) "_makeElCon test3")
  (IS (_makeElCon '((! a) * b)) '(e_c (! a) b) "_makeElCon test4")
  (IS (_makeElCon '((! a) * (! b))) '(e_c (! a) (! b)) "_makeElCon test5")
  (IS (_makeElCon '(e_c a b)) '(e_c a b) "_makeElCon test6")
  (IS (_makeElCon '(e_c (! a) b)) '(e_c (! a) b) "_makeElCon test7")

  (IS (_mergeElCons '(e_c ) '(e_c )) '(e_c ) "_mergeElCons test1")
  (IS (_mergeElCons '(e_c a) '(e_c )) '(e_c a) "_mergeElCons test2")
  (IS (_mergeElCons '(e_c a) '(e_c b)) '(e_c a b) "_mergeElCons test3")
  (IS (_mergeElCons '(e_c a (! a)) '(e_c b)) '(e_c a (! a) b) "_mergeElCons test4")

  (IS (_startElCons '(a)) '((e_c a)) "_startElCons test1")
  (IS (_startElCons '(a + b)) '((e_c a) + (e_c b)) "_startElCons test2")
  (IS (_startElCons '((! a) + b)) '((e_c (! a)) + (e_c b)) "_startElCons test3")
  (IS (_startElCons '((! a) + (b + c))) '((e_c (! a)) + ((e_c b) + (e_c c))) "_startElCons test4")
  (IS (_startElCons '(a + (b + (! c)))) '((e_c a) + ((e_c b) + (e_c (! c)))) "_startElCons test5")
  (IS (_startElCons '(a + (b + (c * d)))) '((e_c a) + ((e_c b) + ((e_c c) * (e_c d)))) "_startElCons test6")
  (IS (_startElCons '((a * 0) + (b + (c * d)))) '(((e_c a) * (e_c 0)) + ((e_c b) + ((e_c c) * (e_c d)))) "_startElCons test7")

  (IS (_mergeSetsElCons '((e_c a)) '((e_c b))) '((e_c a b)) "_mergeSetsElCons test1")
  (IS (_mergeSetsElCons '((e_c a) (e_c (! a))) '((e_c b))) '((e_c a b) (e_c (! a) b)) "_mergeSetsElCons test2")
  (IS (_mergeSetsElCons
        '((e_c a) (e_c (! a)))
        '((e_c b) (e_c c)))
      '((e_c a b) (e_c a c) (e_c (! a) b) (e_c (! a) c))
      "_mergeSetsElCons test3")
  (IS (_mergeSetsElCons
        '((e_c a) (e_c (! a)) (e_c x y))
        '((e_c b) (e_c c)))
      '((e_c a b) (e_c a c) (e_c (! a) b) (e_c (! a) c) (e_c x y b) (e_c x y c))
      "_mergeSetsElCons test4")
  (IS (_mergeSetsElCons
        '((e_c a) (e_c (! a)) (e_c x y))
        '((e_c b) (e_c c (! e))))
      '((e_c a b) (e_c a c (! e)) (e_c (! a) b) (e_c (! a) c (! e)) (e_c x y b) (e_c x y c (! e)))
      "_mergeSetsElCons test5")
  (IS (_mergeSetsElCons
        '((e_c a) (e_c (! a)) (e_c x y))
        '((e_c b) (e_c c) (e_c e)))
      '((e_c a b) (e_c a c) (e_c a e) (e_c (! a) b) (e_c (! a) c) (e_c (! a) e) (e_c x y b) (e_c x y c) (e_c x y e))
      "_mergeSetsElCons test6")

  (IS (CollectElCons '((e_c a))) '((e_c a)) "CollectElCons test1")
  (IS (CollectElCons '((e_c a) + (e_c b))) '((e_c a) (e_c b)) "CollectElCons test2")
  (IS (CollectElCons '((e_c (! a)) + (e_c b))) '((e_c (! a)) (e_c b)) "CollectElCons test3")
  (IS (CollectElCons '((e_c (! a)) + ((e_c b) + (e_c c)))) '((e_c (! a)) (e_c b) (e_c c)) "CollectElCons test4")
  (IS (CollectElCons '((e_c a) + ((e_c b) + (e_c (! c))))) '((e_c a) (e_c b) (e_c (! c))) "CollectElCons test5")
  (IS (CollectElCons '((e_c a) + ((e_c b) + ((e_c c) * (e_c d))))) '((e_c a) (e_c b) (e_c c d)) "CollectElCons test6")
  (IS (CollectElCons '(((e_c a) * (e_c 0)) + ((e_c b) + ((e_c c) * (e_c d))))) '((e_c a 0) (e_c b) (e_c c d)) "CollectElCons test7")

  (print "DONE TESTING"))
