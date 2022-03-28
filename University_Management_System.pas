Program UNIVERSITIES_MANAGMENT_SYSTEM;

//PROJECT AND SOURCE CODE BELONGS TO ALLAOUA OKBA GROUPE 4, 1CPI ESI SBA 2021-2022 DO NOT TRY TO COPY THE SOURCE CODE. ALL RIGHT RESERVED.
///NOTE : L: MEANS LIST AND P MEANS POINTER
///FOR EACH RECORD WE DECLARE THE PRECEDENT POINTER BECAUSE IT CONTAINS IT (THE POINTER) AND WE WILL NEED TO EMPLOYE IT
///EVEN THE USER NEED TO CREATE THE PRECEDENT ELEMENT TO PROCCEED TO THE NEXT ELEMENT HE WANT PER EXAMPLE TO CREATE A SPECIALITY HE IS OBLIGED
///TO CREATE FIRST A DEPARTMENT, THE SAME FOR DEPARTMENT HE NEEDS TO CREATE A FACULTY BEFORE AND FOR THIS LAST HE'S OBLIGED TO CREATE A UNIVERSITY


//LS OF STUDENT
Type
  StudentP = ^StudentL;
  StudentL = Record
    FirstName,LastName: String[30];
    StudentSuivant : StudentP;
  End;


//RECORD OF YEARS WITH STUDENTS
Type
  Year = Record
    //FOR A YEAR WE MADE A RECORD OF STUDENTS IN
    YearSelected : Integer;
    StudentL : StudentP;
  End;


//LS OF SPECIALITY
Type
  SpecialityP = ^SpecialityL;
  SpecialityL = Record
    SpecialityName : String[30];
    Year1,Year2,Year3,Year4,Year5 : Year;
    SpecialitySuivant : SpecialityP;
  End;


// LS OF DEPARTMENT
Type
  DepartmentP = ^DepartmentL;
  DepartmentL = Record
    DepartmentName : String[30];
    SpecialityL : SpecialityP;
    DepartmentSuivant : DepartmentP;
  End;


//LS OF FACULTY
Type
  FacultyP = ^FacultyL;
  FacultyL = Record
    FacultyName : String[30];
    DepartmentL : DepartmentP;
    FacultySuivant : FacultyP;
  End;


//LS OF UNIVERSITY
Type
  UniversityP = ^UniversityL;
  UniversityL = Record
    UniversityName : String[30];
    FacultyL : FacultyP;
    UniversitySuivant : UniversityP;
  End;
Var
  StartPointer: UniversityP; //THIS POINTER WE WILL USE IT A LOT AND IT ENSURE IF THE LIST IS EMPTY OR NOT (UNIVERSITY)


Procedure NewUniversity(S:String);
Var
  L: UniversityP;
Begin
  If (StartPointer<>Nil) Then //ADDING AT THE END
    Begin
      L := StartPointer;
      While (L^.UniversitySuivant<>Nil) Do
        L := L^.UniversitySuivant;
      New(L^.UniversitySuivant);
      L := L^.UniversitySuivant;
      L^.UniversityName := S;
      L^.UniversitySuivant := Nil;
    End
  Else //ADDING AT THE BEGGINING
    Begin
      New(StartPointer);
      L := StartPointer;
    End;
  L^.UniversitySuivant := Nil;
  L^.UniversityName := S;
  L^.FacultyL := Nil; //FACULTY CLOSE (CLOSING IT) NEXT FACULTIES ARE EMPTY FOR NEW UNIVERSITIES
End;


Procedure NewFaculty(S:String;UniversityPointer:UniversityP); //TO CREATE NEW FACULTY IT SHOULD MENTION ON WHICH UNIVERSITY (THE USER NEED TO CREATE UNIVERSITY BEFORE, IF IT CREATED WE WILL USE THE SEARCH FUNCTION TO ENSURE THAT)
Var
  L: FacultyP;
Begin
  If (UniversityPointer<>Nil) Then //CHECK IF THE UNIVERSITY EXISTS
    Begin
      If (UniversityPointer^.FacultyL<>Nil) Then //ADDING FACULTY AT THE END
        Begin
          L := UniversityPointer^.FacultyL;
          While (L^.FacultySuivant<>Nil) Do
            L := L^.FacultySuivant;
          New(L^.FacultySuivant);
          L := L^.FacultySuivant;
        End
      Else //ADDING FACULTY AT THE BEGINING
        Begin
          New(UniversityPointer^.FacultyL);
          L := UniversityPointer^.FacultyL;
        End;
      L^.FacultySuivant := Nil; //FILL THE ELEMENT ADDED AT THE BEGGINING OR AT THE END
      L^.FacultyName := S;
      L^.DepartmentL := Nil //DEPARTMENTS ARE EMPTY FOR NEW FACULTIES
    End
  Else Writeln('No University with this name'); //UNIVERSITY DOESN'T EXIST
End;


Procedure NewDepartment(S:String;FacultyPointer:FacultyP); //TO CREATE NEW DEP IT SHOULD MENTION ON WHICH FACULTY (THE USER NEED TO CREATE FACULTY BEFORE, IF IT CREATED WE WILL USE THE SEARCH FUNCTION TO ENSURE THAT)
Var
  L: DepartmentP;
Begin
  If (FacultyPointer<>Nil) Then //CHECK IF THE FACULTY EXISTS
    Begin
      If (FacultyPointer^.DepartmentL<>Nil) Then //ADDING DEPARTMENT AT THE END
        Begin
          L := FacultyPointer^.DepartmentL;
          While (L^.DepartmentSuivant<>Nil) Do
            L := L^.DepartmentSuivant;
          New(L^.DepartmentSuivant);
          L := L^.DepartmentSuivant;
        End
      Else //ADDING DEPARTMENT AT THE BEGINING
        Begin
          New(FacultyPointer^.DepartmentL);
          L := FacultyPointer^.DepartmentL;
        End;
      L^.DepartmentSuivant := Nil; //FILL THE ELEMENT ADDED AT THE BEGGINING OR AT THE END
      L^.DepartmentName := S;
      L^.SpecialityL := Nil //SPECIALITIES ARE EMPTY FOR NEW DEPARTMENTS
    End
  Else Writeln('No Faculty with this name'); //FACULTY DOESN'T EXIST
End;


Procedure NewSpeciality(S:String;DepartmentPointer:DepartmentP); //TO CREATE NEW SPECIALITY IT SHOULD MENTION ON WHICH DEP (THE USER NEED TO CREATE DEPARTMENT BEFORE, IF IT CREATED WE WILL USE THE SEARCH FUNCTION TO ENSURE THAT)
Var
  L: SpecialityP;
Begin
  If (DepartmentPointer<>Nil) Then //CHECK IF THE DEPARTMENT EXISTS
    Begin
      If (DepartmentPointer^.SpecialityL<>Nil) Then //ADDING SPECIALITY AT THE END
        Begin
          L := DepartmentPointer^.SpecialityL;
          While (L^.SpecialitySuivant<>Nil) Do
            L := L^.SpecialitySuivant;
          New(L^.SpecialitySuivant);
          L := L^.SpecialitySuivant;
        End
      Else //ADDING SPECIALITY AT THE BEGINING
        Begin
          New(DepartmentPointer^.SpecialityL);
          L := DepartmentPointer^.SpecialityL;
        End;
      L^.SpecialitySuivant := Nil; //FILL THE ELEMENT ADDED AT THE BEGGINING OR AT THE END
      L^.SpecialityName := S;
      L^.Year1.StudentL := Nil; //STUDENTS ON YEARS ARE EMPTY FOR NEW SPECIALITIES
      L^.Year2.StudentL := Nil;
      L^.Year3.StudentL := Nil;
      L^.Year4.StudentL := Nil;
      L^.Year5.StudentL := Nil;
    End
  Else Writeln('No Department with this name'); //DEPARTMENT DOESN'T EXIST
End;


Procedure NewStudent(FirstName,LastName:String;StudyYear:Integer;SpecialityPointer:SpecialityP); //AS ALWAYS, TO CREATE NEW STUDENT IT SHOULD BE MENTIONED WHICH SPECIALITY (THE USER NEED TO CREATE
//SPECIALITY BEFORE, IF IT CREATED WE WILL USE THE SEARCH FUNCTION TO ENSURE THAT)
Var
  L: StudentP; //STUDENT POINTER
  YearAdded: Year; //TO AFFECT THE YEAR ADDED TO
Begin
  If (SpecialityPointer<>Nil) Then
    Begin
      Case StudyYear Of //THIS CASE FIND THE STUDYYEAR ENTRED AND DIRECT IT TO ONE OF THE FOLLOWING YEARS'S POINTER
        1: YearAdded := SpecialityPointer^.Year1;
        2: YearAdded := SpecialityPointer^.Year2;
        3: YearAdded := SpecialityPointer^.Year3;
        4: YearAdded := SpecialityPointer^.Year4;
        5: YearAdded := SpecialityPointer^.Year5;
      End;
      If (YearAdded.StudentL<>Nil) Then //ADDING STUDENT AT THE END OF THE LIST
        Begin
          L := YearAdded.StudentL;
          While (L^.StudentSuivant<>Nil) Do
            L := L^.StudentSuivant;
          New(L^.StudentSuivant);
          L := L^.StudentSuivant;
        End
      Else //ADDING AT THE BEGGING OF THE LIST
        Begin
          Case StudyYear Of
            1:
               Begin
                 New(SpecialityPointer^.Year1.StudentL);
                 L := SpecialityPointer^.Year1.StudentL;
               End;
            2:
               Begin
                 New(SpecialityPointer^.Year2.StudentL);
                 L := SpecialityPointer^.Year2.StudentL;
               End;
            3:
               Begin
                 New(SpecialityPointer^.Year3.StudentL);
                 L := SpecialityPointer^.Year3.StudentL;
               End;
            4:
               Begin
                 New(SpecialityPointer^.Year4.StudentL);
                 L := SpecialityPointer^.Year4.StudentL;
               End;
            5:
               Begin
                 New(SpecialityPointer^.Year5.StudentL);
                 L := SpecialityPointer^.Year5.StudentL;
               End;
          End;
        End;
      L^.StudentSuivant := Nil; //FILL THE ELEMENT ADDED AT THE BEGGINING OR AT THE END /NEXT STUDENTPOINTER IS EMPTY
      L^.FirstName := FirstName; //FULL NAME FILLING
      L^.LastName := LastName;
    End
  Else Writeln('No Speciality With this name'); //Speciality DOESN'T EXIST
End;


//IMPORTANT : SEARCH FUNCTONS ARE NOT BOOLEAN THEY'RE FUNCTIONS THAT APPOINT AT THE ELEMENT SEARCHED, AT THE PRINCIPAL PROGRAM WE ADD CONDITION OF NIL TO WRITELN('FOUND') OR NOT
Function UniversitySearch(UniversityName:String): UniversityP; //NOT IN TP FUNCTION (WE NEED IT TO DEPARTMENT DELETE)
Var
  L: UniversityP;
Begin
  L := StartPointer; //AFFECT THE FIRST POINTER WE DECLARE AT THE LINE 54
  While ((L<>Nil) And (L^.UniversityName<>UniversityName)) Do //JUMP THE LIST UNTIL FINDING THE NAME MATCHING
    L := L^.UniversitySuivant;
  UniversitySearch := L;
End;


Function FacultySearch(FacultyName:String): FacultyP; //WE SEARCH ON THE ON THE FIRST UNIVERSITY IF WE DON'T FIND IT WE JEMP TO THE NEXT UNIVERSITY AND WE GO UNTIL THE LAST ONE
Var
  L1: UniversityP;
  L2: FacultyP;
Begin
  L1 := StartPointer;
  L2 := Nil;
  While (L1<>Nil) Do
    Begin
      L2 := L1^.FacultyL; //AFFECT THE FACULTY OF UNIVERSITY TO THE FACULTY POINTER TO ASSURE IT EXISTANCE LATER
      While ((L2<>Nil) And (L2^.FacultyName<>FacultyName)) Do //SEARCHING FOR THE FACULTY NAME CONDITION
        L2 := L2^.FacultySuivant; //JUMPING THE LIST TO FIND THE FACULTY
      If (L2<>Nil) Then //ANOTHER CONDITION
        L1 := Nil
      Else
        L1 := L1^.UniversitySuivant; //IF THE POINTER ARRIVE TO THE LAST ELEMENT AND DIDN'T FIND THE FACULTY HE WILL JUMP THE UNIVERSITY TO SEARCH IN ANOTHER ONE
    End;
  FacultySearch := L2;
End;


Function DepartmentSearch(DepartmentName:String): DepartmentP; //SAME AS THE FIRST ONE WE SEARCH ON UNIVERSITIES AFTER THAT THE FACULTIES AND THEN THE DEPARTMENTS
Var
  L1: UniversityP;
  L2: FacultyP;
  L3: DepartmentP;
Begin
  L1 := StartPointer;
  L3 := Nil;
  While (L1<>Nil) Do //ASURING IF THE UNIVERSITY EXISTS OR EMPTY
    Begin
      L2 := L1^.FacultyL; //AFFECTING THE FACULTY OF THE UNIVERSITY SELECTED ON THE LOOP TO THE POINTER
      While (L2<>Nil) Do //ASURING IF THE FACULTY EXISTS OR EMPTY
        Begin
          L3 := L2^.DepartmentL; //AFFECTING THE DEPARTMENT OF THE FACULTY SELECTED ON THE LOOP TO THE POINTER
          While (L3<>Nil) And (L3^.DepartmentName<>DepartmentName) Do //SEARCHING FOR THE NAME OF THE DEPARTMENT
            L3 := L3^.DepartmentSuivant; //IF NOT FOUND IT KEEP JUMPING TO ANOTHER DEPARTMENT
          If (L3<>Nil) Then
            Begin
              L1 := Nil;
              L2 := Nil;
            End
          Else
            L2 := L2^.FacultySuivant; //JUMPING TO ANOTHER FACULTY
        End;
      If (L1<>Nil) Then L1 := L1^.UniversitySuivant; //JUMPING TO ANOTHER UNIVERSITY
    End;
  DepartmentSearch := L3;
End;


Function SpecialitySearch(SpecialityName:String): SpecialityP; //SAME AS THE FIRST ONE WE SEARCH ON UNIVERSITIES AFTER THAT THE FACULTIES AND THEN THE DEPARTMENTS AFTER THAT THE SPECIALITY
Var
  L1: UniversityP;
  L2: FacultyP;
  L3: DepartmentP;
  L4: SpecialityP;
Begin
  L1 := StartPointer;
  L4 := Nil;
  While (L1<>Nil) Do //ASURING IF THE UNIVERSITY EXISTS OR EMPTY
    Begin
      L2 := L1^.FacultyL; //AFFECTING THE FACULTY OF THE UNIVERSITY SELECTED ON THE LOOP TO THE POINTER
      While (L2<>Nil) Do //ASURING IF THE FACULTY EXISTS OR EMPTY
        Begin
          L3 := L2^.DepartmentL; //AFFECTING THE DEPARTMENT OF THE FACULTY SELECTED ON THE LOOP TO THE POINTER
          While (L3<>Nil) Do
            Begin
              L4 := L3^.SpecialityL; //AFFECTING THE SPECIALITY OF THE DEPARTMENT SELECTED ON THE LOOP TO THE POINTER
              While ((L4 <> Nil) And (L4^.SpecialityName<>SpecialityName)) Do //SEARCHING FOR THE NAME OF THE DEPARTMENT
                L4 := L4^.SpecialitySuivant; //IF NOT FOUND IT KEEP JUMPING TO ANOTHER SPECIALITY
              If (L4<>Nil) Then
                Begin
                  L1 := Nil;
                  L2 := Nil;
                  L3 := Nil;
                End
              Else
                L3 := L3^.DepartmentSuivant; //JUMPING TO ANOTHER DEPARTMENT
            End;
          If (L2<>Nil) Then
            L2 := L2^.FacultySuivant; //JUMPING TO ANOTHER FACULTY IF THE NOT FOUND
        End;
      If (L1<>Nil) Then L1 := L1^.UniversitySuivant; //JUMPING TO ANOTHER UNIVERSITY
    End;
  SpecialitySearch := L4;
End;


Function StudentSearch(FirstName,LastName:String): StudentP;
Var
  i: Integer;
  AdditionalPointer: SpecialityP; //TO SAVE THE LS FROM NOT ACCESS
  L1: UniversityP;
  L2: FacultyP;
  L3: DepartmentP;
  L4: SpecialityP;
  L5: StudentP;
Begin
  L1 := StartPointer;
  L5 := Nil;
  While (L1<>Nil) Do//ASURING IF THE UNIVERSITY EXISTS OR EMPTY
    Begin
      L2 := L1^.FacultyL; //AFFECTING THE FACULTY OF THE UNIVERSITY SELECTED ON THE LOOP TO THE POINTER
      While (L2<>Nil) Do //ASURING IF THE FACULTY EXISTS OR EMPTY
        Begin
          L3 := L2^.DepartmentL; //AFFECTING THE DEPARTMENT OF THE FACULTY SELECTED ON THE LOOP TO THE POINTER
          While (L3<>Nil) Do
            Begin
              L4 := L3^.SpecialityL; //AFFECTING THE SPECIALITY OF THE DEPARTMENT SELECTED ON THE LOOP TO THE POINTER
              While (L4 <> Nil) Do //AFFECTING THE STUDENTPOINTER TO THE SPECIALITY SELECTED ON THE LOOP TO THE POINTER
                Begin
                  i := 1;
                  Repeat
                    Case i Of //USING A COUNTER TO JUMP OVER THE YEARS THE FIRST TIME IT GOES TO FIRST YEAR AND CHECK THE STUDENTS IF NOT FOUND IT WILL GO TO THE SECOND YEAR AND IT CONTINUES UNTIL LAST YEAR (FIFTH YEAR)
                      1: L5 := L4^.Year1.StudentL;
                      2: L5 := L4^.Year2.StudentL;
                      3: L5 := L4^.Year3.StudentL;
                      4: L5 := L4^.Year4.StudentL;
                      5: L5 := L4^.Year5.StudentL;
                    End;
                    //CASE END
                    While ((L5<>Nil) And (L5^.FirstName<>FirstName) And (L5^.LastName<>LastName)) Do
                      L5 := L5^.StudentSuivant;
                    If (L5<>Nil) Then
                      Begin
                        L1 := Nil;
                        L2 := Nil;
                        L3 := Nil;
                        L4 := Nil;
                        AdditionalPointer := L4; //WE ADDED THE AdditionalPointer TO SAVE THE SPECIALITY POINTYER BECAUSE WE WILL USE IT TO JUMP THE OTHER SPECIALITIES
                        i := 6;
                      End
                    Else
                      i := i+1;
                  Until (i=6);
                  If (L4<>Nil) Then //IF THE STUDENT NOT FOUND ON THE CURRENT SEARCHABLE SPECIALITY IT JUMP TO THE NEXT
                    L4 := L4^.SpecialitySuivant;
                End;
              If (L3<>Nil) Then //IF THE SPECIALITY NOT FOUND ON THE CURRENT SEARCHABLE DEPARTMENT IT JUMP TO THE NEXT
                L3 := L3^.DepartmentSuivant;
            End;
          If (L2<>Nil) Then //IF THE DEP NOT FOUND ON THE CURRENT SEARCHABLE FACULTY IT JUMP TO THE NEXT
            L2 := L2^.FacultySuivant;
        End;
      If (L1<>Nil) Then //IF THE FACULTY NOT FOUND ON THE CURRENT SEARCHABLE UNIVERSITY IT JUMP TO THE NEXT
        L1 := L1^.UniversitySuivant;
    End;
  StudentSearch := L5;
End;


Procedure DeleteFaculty(FacultyName:String;UniversityPointer:UniversityP); //THIS PROCEDURE WILL USE A BOOLEAN VARIABLE TO JUMP A
Var
  FacultyPointer1,FacultyPointer2: FacultyP; //POINTER1 TO JUMP IN THE SAME UNIVERSITY AND 2 TO JUMP TO ANOTHER UNIVERSITY
  DepartmentPointer: DepartmentP;
  SpecialityPointer: SpecialityP;
  i: Integer; //TO JUMP YEARS IF NO FOUND UNTIL LAST YEAR
  b: Boolean; //BOOLEAN VARIABLE SAYS IF STUDENTS EXISTS OR NO TO JUMP TO ANOTHER YEAR ON A SPECIFIC FACULTY USING i;
Begin
  b := False;
  If (UniversityPointer<>Nil) Then
    Begin
      FacultyPointer1 := FacultySearch(FacultyName); //FIRST POINTER WILL TAKE THE FacultySearch FUNCTION POINTER TO ENTER THE DEPARTMENT AND CONTINUE SEARCHING
      If (FacultyPointer1<>Nil) Then
        Begin
          If (FacultyPointer1^.DepartmentL<>Nil) Then
            Begin
              DepartmentPointer := FacultyPointer1^.DepartmentL; //DepartmentPointer TO TAKE THE SPECIFIC DEPARTMENT FIRST ONE THEN CONTINUE
              While ((DepartmentPointer<>Nil) And (Not(b))) Do //THE BOOLEAN SHOULD BE FALSE TO CONTINUE JUMPING THE DEPS AND SPECIALITIES
                Begin
                  SpecialityPointer := DepartmentPointer^.SpecialityL; //SpecialityPointer TO TAKE THE SPECIFIC SPECIALITY FIRST ONE THEN CONTINUE
                  While ((SpecialityPointer<>Nil) And (Not(b))) Do
                    Begin
                      i := 1; //STARTING USING THE COUNTERS TO CHECK YEARS STUDENTS IF FOUNDED ONE STUDENT OR NOT
                      While ((i<6) And (Not(b))) Do
                        Begin
                          Case i Of
                            1: If (SpecialityPointer^.Year1.StudentL<>Nil) Then b := True; //ONE STUDENT THE BOOLEAN CHANGES TO TRUE WHICH MEANS WE FOUND A STUDENT ON A SPECIALITY, SO ALL THE WHILE LOOPS ARE CLOSING
                            2: If (SpecialityPointer^.Year2.StudentL<>Nil) Then b := True;
                            3: If (SpecialityPointer^.Year3.StudentL<>Nil) Then b := True;
                            4: If (SpecialityPointer^.Year4.StudentL<>Nil) Then b := True;
                            5: If (SpecialityPointer^.Year5.StudentL<>Nil) Then b := True;
                          End;
                          i := i + 1;
                        End;
                      SpecialityPointer := SpecialityPointer^.SpecialitySuivant; //SEARCHING NEXT SPECIALITY
                    End;
                  DepartmentPointer := DepartmentPointer^.DepartmentSuivant; //NEXT DEPARTMENT THEN
                End;
            End;
          If (Not(b)) Then //AFTER ASURING THAT A NO STUDENT FOUND WE NEED TO FIND IF THE FACULTY EXISTS
            Begin
              If (FacultyPointer1<>UniversityPointer^.FacultyL) Then
                Begin
                  FacultyPointer2 := UniversityPointer^.FacultyL; //SECOND POINTER TO JUMP ANOTHER UNIVERSITY
                  While ((FacultyPointer2^.FacultySuivant<>FacultyPointer1) And (FacultyPointer2^.
                        FacultySuivant<>Nil)) Do //FIRST CONDITION TO CHECK IF WE ARE JUMPING TO ANOTHER FACULTY NOT THE ONE WE FOUND ON SEARCH AND THE SECOND IF WE DIDN''T COME TO AN END
                    FacultyPointer2 := FacultyPointer2^.FacultySuivant; //JUMPING NEXT FACULTY
                  If (FacultyPointer2<>Nil) Then //DELETING THE FACULTY
                    Begin
                      FacultyPointer2^.FacultySuivant := FacultyPointer1^.FacultySuivant;
                      Dispose(FacultyPointer1);
                    End
                  Else Writeln('Faculty Not Found In The University Searched In'); //WE ARRIVED TO THE END AND WE DIDN'T DISPOSE IT MEAN IT DOESN'T EXIST OR STUDENT EXISTE
                End
              Else
                Begin
                  UniversityPointer^.FacultyL := FacultyPointer1^.FacultySuivant; //ANOTHER FACULTY TO SEARCH
                  Dispose(FacultyPointer1); //DELETED
                End;
            End
          Else Writeln('Can''t Delete The faculty A Student Has Been Spoted');
        End
      Else Writeln('No Faculty Founded');
    End
  Else Writeln('No University Founded');
End;


Procedure DeleteDepartment(DepartmentName:String;FacultyPointer:FacultyP);
Var
  DepartmentPointer1, DepartmentPointer2: DepartmentP;
  SpecialityPointer: SpecialityP;
  i: Integer;
  b: Boolean;
Begin
  b := False; //FIRST POINTER WILL TAKE THE DepartmentSearch FUNCTION POINTER TO ENTER THE DEPARTMENT AND CONTINUE SEARCHING
  If (FacultyPointer<>Nil) Then
    Begin
      DepartmentPointer1 := DepartmentSearch(DepartmentName);
      If (DepartmentPointer1<>Nil) Then
        Begin //DepartmentPointer TO TAKE THE SPECIFIC DEPARTMENT FIRST ONE THEN CONTINUE
          If (DepartmentPointer1^.SpecialityL<>Nil) Then //THE BOOLEAN SHOULD BE FALSE TO CONTINUE JUMPING THE DEPS AND SPECIALITIES
            Begin
              SpecialityPointer := DepartmentPointer1^.SpecialityL; //SpecialityPointer TO TAKE THE SPECIFIC SPECIALITY FIRST ONE THEN CONTINUE
              While ((SpecialityPointer<>Nil) And (Not(b))) Do
                Begin
                  i := 1; //STARTING USING THE COUNTERS TO CHECK YEARS STUDENTS IF FOUNDED ONE STUDENT OR NOT
                  While ((i<6) And (Not(b))) Do
                    Begin
                      Case i Of
                        1: If (SpecialityPointer^.Year1.StudentL<>Nil) Then b := True; //ONE STUDENT THE BOOLEAN CHANGES TO TRUE WHICH MEANS WE FOUND A STUDENT ON A SPECIALITY, SO ALL THE WHILE LOOPS ARE CLOSING
                        2: If (SpecialityPointer^.Year2.StudentL<>Nil) Then b := True;
                        3: If (SpecialityPointer^.Year3.StudentL<>Nil) Then b := True;
                        4: If (SpecialityPointer^.Year4.StudentL<>Nil) Then b := True;
                        5: If (SpecialityPointer^.Year5.StudentL<>Nil) Then b := True;
                      End;
                      i := i + 1;
                    End;
                  SpecialityPointer := SpecialityPointer^.SpecialitySuivant; //SEARCHING NEXT SPECIALITY
                End; //NEXT DEPARTMENT THEN
            End;
          If (Not(b)) Then //AFTER ASURING THAT A NO STUDENT FOUND WE NEED TO FIND IF THE FACULTY EXISTS
            Begin
              If (DepartmentPointer1<>FacultyPointer^.DepartmentL) Then
                Begin
                  DepartmentPointer2 := FacultyPointer^.DepartmentL; //SECOND POINTER TO JUMP ANOTHER FACULTY
                  While ((DepartmentPointer2^.DepartmentSuivant<>DepartmentPointer1) And (DepartmentPointer2^.DepartmentSuivant<>Nil)) Do
                  //FIRST CONDITION TO CHECK IF WE ARE JUMPING TO
                  //ANOTHER DEPARTMENT NOT THE ONE WE FOUND ON SEARCH AND THE SECOND IF WE DIDN''T COME TO AN END
                    DepartmentPointer2 := DepartmentPointer2^.DepartmentSuivant; //JUMPING NEXT DEPARTMENT
                  If (DepartmentPointer2<>Nil) Then //DELETING THE DEPARTMENT
                    Begin
                      DepartmentPointer2^.DepartmentSuivant := DepartmentPointer1^.DepartmentSuivant;
                      Dispose(DepartmentPointer1);
                    End
                  Else Writeln('Department Not Found In The Faculty Searched In'); //WE ARRIVED TO THE END AND WE DIDN'T DISPOSE IT MEAN IT DOESN'T EXIST OR STUDENT EXISTE
                End
              Else
                Begin
                  FacultyPointer^.DepartmentL := DepartmentPointer1^.DepartmentSuivant; //ANOTHER DEPARTMENT TO SEARCH
                  Dispose(DepartmentPointer1);
                End;
            End
          Else Writeln('Can''t Delete The Department A Student Has Been Spoted');
        End
      Else Writeln('No Department Founded');
    End
  Else Writeln('No Faculty Founded');
End;


Procedure DeleteSpeciality(SpecialityName:String;DepartmentPointer:DepartmentP);
Var
  SpecialityPointer1,SpecialityPointer2: SpecialityP; //AS ALWAYS TWO POINTERS ONE FOR THE FUNCTION AND THE OTHER ONE TO ENTER THE SPECIALITIES
  i: Integer;
  b: Boolean;
Begin
  b := False;
  If (DepartmentPointer<>Nil) Then
    Begin
      SpecialityPointer1 := SpecialitySearch(SpecialityName); //STARTING ENTRING THE SPECIALITIES
      If (SpecialityPointer1<>Nil) Then //ENTRING THE YEARS
        Begin
          i := 1; //COUNTER TO INCREMENT AFTER FINISHING WITH EACH YEAR
          While ((i < 6) And (Not(b))) Do
            Begin
              Case i Of
                1: If (SpecialityPointer1^.Year1.StudentL<>Nil) Then b := True;
                2: If (SpecialityPointer1^.Year2.StudentL<>Nil) Then b := True;
                3: If (SpecialityPointer1^.Year3.StudentL<>Nil) Then b := True;
                4: If (SpecialityPointer1^.Year4.StudentL<>Nil) Then b := True;
                5: If (SpecialityPointer1^.Year5.StudentL<>Nil) Then b := True;
              End;
              i := i+1;
            End;
          If (Not(b)) Then //IF NO STUDENT FOUND THE PROGRAM CHECK IF THE SPECIALITY,DEPARTMENT EXISTS
            Begin
              If (SpecialityPointer1<>DepartmentPointer^.SpecialityL) Then
                Begin
                  SpecialityPointer2 := DepartmentPointer^.SpecialityL;
                  While ((SpecialityPointer2^.SpecialitySuivant<>SpecialityPointer1) And (
                        SpecialityPointer2^.SpecialitySuivant<>Nil)) Do //JUMP UNTIL FINDING MATCHMAKING
                    SpecialityPointer2 := SpecialityPointer2^.SpecialitySuivant; //JUMPING ELEMENTS
                  If (SpecialityPointer2<>Nil) Then //IF WE FOUND THE ELEMENT SEARCHED FOR AND WE DIDN'NT ARRIVE TO NIL IT MEAN WE FIND IT SO (DISPOSE TIME)
                    Begin
                      SpecialityPointer2^.SpecialitySuivant := SpecialityPointer1^.SpecialitySuivant
                      ;
                      Dispose(SpecialityPointer1);
                    End
                  Else Writeln('Speciality Not Found In The Department Searched In'); //ELSE WE DIDN'T FIND IT
                End
              Else
                Begin
                  DepartmentPointer^.SpecialityL := SpecialityPointer1^.SpecialitySuivant;
                  Dispose(SpecialityPointer1); //WE DISPOSE ALSO DIRECTLY IF THEY'RE EQUAL AT THE BEGINING
                End;
            End
          Else Writeln('Can''t Delete The Department A Student Has Been Spoted');
        End
      Else Writeln('No Speciality Founded');
    End
  Else Writeln('No Department Founded');
End;


Procedure DeleteStudent(FirstName,LastName:String;StudyYear:Integer); //SAME METHODE AS THE OTHER ONES TWO POINTERS AND SEARCHING BY USING THE SEARCH FUNCTION
Var
  StudentPointer1,StudentPointer2: StudentP; //TWO POINTERS ONE FOR THE FUNCTION SECOND TO ACCESS THE NEXT ELEMENTS
  SpecialityPointer: SpecialityP;
Begin
  StudentPointer1 := StudentSearch(FirstName,LastName);
  StudentPointer2 := SpecialityPointer^.Year1.StudentL;
  If (StudentPointer1<>Nil) Then
    Begin
      If (StudentPointer1<>StudentPointer2) Then //DELETING AT THE END
        Begin
          While (StudentPointer2^.StudentSuivant<>StudentPointer1) Do
            StudentPointer2 := StudentPointer2^.StudentSuivant;
          StudentPointer2^.StudentSuivant := StudentPointer1^.StudentSuivant;
          Dispose(StudentPointer1);
        End
      Else Case StudyYear Of //DELETE FROM BEGINING
             1 : If SpecialityPointer^.Year1.StudentL=StudentPointer1 Then //IF IT EXISTS
                   Begin
                     SpecialityPointer^.Year1.StudentL := StudentPointer1^.StudentSuivant;
                     Dispose(StudentPointer1)
                   End
                 Else Writeln('No Student In This Year'); //IF NOT
             2 : If SpecialityPointer^.Year2.StudentL=StudentPointer1 Then
                   Begin
                     SpecialityPointer^.Year2.StudentL := StudentPointer1^.StudentSuivant;
                     Dispose(StudentPointer1)
                   End
                 Else Writeln('No Student In This Year');
             3 : If SpecialityPointer^.Year3.StudentL=StudentPointer1 Then
                   Begin
                     SpecialityPointer^.Year3.StudentL := StudentPointer1^.StudentSuivant;
                     Dispose(StudentPointer1)
                   End
                 Else Writeln('No Student In This Year');
             4 : If SpecialityPointer^.Year4.StudentL=StudentPointer1 Then
                   Begin
                     SpecialityPointer^.Year4.StudentL := StudentPointer1^.StudentSuivant;
                     Dispose(StudentPointer1)
                   End
                 Else Writeln('No Student In This Year');
             5 : If SpecialityPointer^.Year5.StudentL=StudentPointer1 Then
                   Begin
                     SpecialityPointer^.Year5.StudentL := StudentPointer1^.StudentSuivant;
                     Dispose(StudentPointer1)
                   End
                 Else Writeln('No Student In This Year');
        End;
    End
  Else Writeln('No Student Founded');
End;


Procedure SWAP(Var S1,S2:String); //SWAP PROCEDURE TO SWAP ELEMENTS ON SORTING PROCEDURE (.14)
Var
  C: String;
Begin
  C := S1;
  S1 := S2;
  S2 := C;
End;


Procedure Sort(S:StudentP); //WE JUMP THE LIST SO WE COMPARE NAMES AND WE SWAP THEM UNTIL IT EQUALS TO STOP THE TIME IT IS EQUAL STOP IS AT THE BEGGINING OF THE LIST SORTED
Var
  L,X,STOP: StudentP;
Begin
  If ((S<>Nil) And (S^.StudentSuivant<>Nil)) Then
    Begin
      STOP := Nil;
      While STOP<>S Do
        Begin
          L := S;
          While (L<>STOP) Do
            Begin
              If (L^.StudentSuivant<>Nil) Then
                If L^.FirstName>L^.StudentSuivant^.FirstName Then
                  Begin
                    Swap(L^.FirstName,L^.StudentSuivant^.FirstName); //WHEN SWAPPING THE FIRST NAME WE NEED TO SWAP THE SECOND TOO
                    Swap(L^.LastName,L^.StudentSuivant^.LastName);
                  End;
              X := L;
              L := L^.StudentSuivant; //JUMP NEXT ELEMENT
            End;
          STOP := X;
        End;
    End;
End;


Procedure SortStudents(SpecialityName:String;DepartmentName:String);
//WE AFFECT THE TWO FIRST POINTERS THE TWO SEARCH FUNCTIONS POINTERS IF WE DIDN'T FIND THE POINTER IT MEANS
//NO DEP OR SPECIALITY IN THAT NAME ELSE WE GO TO THE YEARS WHERE WE SORD EACH STUDENT ALONE IN EACH YEAR
//NOTE : SORTING IS ABOUT FIRST NAME AS USUALY
Var
  L1: DepartmentP;
  L2: SpecialityP;
  L3: StudentP;
  i: Integer;
Begin
  L1 := DepartmentSearch(DepartmentName);
  L2 := SpecialitySearch(SpecialityName);
  If (L1=Nil) Then Writeln('Can''t Find Matchhing Department')
  Else If (L2=Nil) Then Writeln('Can''t Find Matchhing Speciality')
  Else
    Begin
      While (L1<>Nil) Do
        Begin
          L2 := L1^.SpecialityL; //AFFECTING THE SPECIALITY OF THE DEP SELECTED ON THE LOOP TO THE POINTER
          While (L2<>Nil) Do
            Begin
              i := 1;
              Repeat
                Case i Of
                  1:
                     Begin
                       L3 := L2^.Year1.StudentL;
                       Sort(L3); //AFFECTING THE STUDENT OF A SPECIFIC YEAR TO THE SPECIALITY SELECTED ON THE LOOP TO THE POINTER
                     End;
                  2:
                     Begin //SAME FOR THE OTHER YEARS
                       L3 := L2^.Year2.StudentL;
                       Sort(L3);
                     End;
                  3:
                     Begin
                       L3 := L2^.Year3.StudentL;
                       Sort(L3);
                     End;
                  4:
                     Begin
                       L3 := L2^.Year4.StudentL;
                       Sort(L3);
                     End;
                  5:
                     Begin
                       L3 := L2^.Year5.StudentL;
                       Sort(L3);
                     End;
                End;
                While (L3<>Nil) Do
                  Begin
                    L3 := L3^.StudentSuivant;
                  End;
                i := i+1;
              Until (i=6);
              If (L3=Nil) Then Writeln('All Students Has Been Sorted');
              L2 := L2^.SpecialitySuivant; //JUMP TO NEXT SPECIALITY TO SHOW IT
            End;
          L1 := L1^.DepartmentSuivant; //JUMP TO NEXT DEPARTMENT TO SHOW IT
        End;
    End;
End;


Procedure ShowResult(StartPointer:UniversityP);
Var
  L1: UniversityP;
  L2: FacultyP;
  L3: DepartmentP;
  L4: SpecialityP;
  L5: StudentP;
  i,j: Integer; //J IS JUST FOR DISPLAY THE NUMBER OF THE LIST
Begin
j:=0;
  L1 := StartPointer;
  While (L1<>Nil) Do
    Begin
    j:=j+1;
        Writeln;
      Writeln('The University ',j,' Is : ',L1^.UniversityName);
      L2 := L1^.FacultyL; //AFFECTING THE FACULTY OF THE UNIVERSITY SELECTED ON THE LOOP TO THE POINTER
      While (L2<>Nil) Do
        Begin
          Writeln('   The Faculty Is : ',L2^.FacultyName);
          L3 := L2^.DepartmentL; //AFFECTING THE DEPARTMENT OF THE FACULTY SELECTED ON THE LOOP TO THE POINTER
          While (L3<>Nil) Do
            Begin
              Writeln('      The Department Is : ',L3^.DepartmentName);
              L4 := L3^.SpecialityL; //AFFECTING THE SPECIALITY OF THE DEP SELECTED ON THE LOOP TO THE POINTER
              While (L4<>Nil) Do
                Begin
                  Writeln('         The Speciality Is : ',L4^.SpecialityName);
                  i := 1;
                  Repeat
                    Case i Of
                      1:
                         Begin
                           Writeln('  1st Year Student');
                           L5 := L4^.Year1.StudentL; //AFFECTING THE STUDENT OF A SPECIFIC YEAR TO THE SPECIALITY SELECTED ON THE LOOP TO THE POINTER
                         End;
                      2:
                         Begin
                           Writeln('  2nd Year Student'); //SAME FOR THE OTHER YEARS
                           L5 := L4^.Year2.StudentL;
                         End;
                      3:
                         Begin
                           Writeln('  3rd Year Student');
                           L5 := L4^.Year3.StudentL;
                         End;
                      4:
                         Begin
                           Writeln('  4th Year Student');
                           L5 := L4^.Year4.StudentL;
                         End;
                      5:
                         Begin
                           Writeln('  5th Year Student');
                           L5 := L4^.Year5.StudentL;
                         End;
                    End;
                    If (L5=Nil) Then Writeln('        No Students Here')
                    Else
                      Begin
                        While (L5<>Nil) Do
                          Begin
                            Writeln('    Full Student Name is : ',L5^.FirstName,' ',L5^.LastName);
                            L5 := L5^.StudentSuivant;
                          End;
                      End;
                    i := i+1;
                  Until (i=6);
                  L4 := L4^.SpecialitySuivant; //JUMP TO NEXT SPECIALITY TO SHOW IT
                End;
              L3 := L3^.DepartmentSuivant; //JUMP TO NEXT DEPARTMENT TO SHOW IT
            End;
          L2 := L2^.FacultySuivant; //JUMP TO NEXT FACULTY TO SHOW IT
        End;
      L1 := L1^.UniversitySuivant; //JUMP TO NEXT UNIVERSITY TO SHOW IT
    End;
End;


Procedure TEMPLATE1; //FOR A FASTER RESULT WE ADD SOME DATA'S
Var
  S,S1,S2,S3: String[30];
  ClassYear: Integer;
Begin
  S := 'ECOLE SUPERIEUR D''INFORMATIQUE';
  NewUniversity(S);
  S1 := 'ESI SBA';
  NewFaculty(S1, UniversitySearch(S));
  S := 'CPI';
  NewDepartment(S, FacultySearch(S1));
  S1 := 'INFORMATIQUE';
  NewSpeciality(S1, DepartmentSearch(S));
  ///1CPI
  S2 := 'ALLAOUA';
  S3 := 'OKBA';
  ClassYear := 1;
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  S2 := 'BELKHARCHOUCHE';
  S3 := 'SOUNDOS';
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  S2 := 'SALMI';
  S3 := 'OUSSAMA';
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  S2 := 'DJEZIRI';
  S3 := 'OUSSAMA';
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  S2 := 'BEN BAKRITI';
  S3 := 'MOHAMED EL AMINE';
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  S2 := 'BAHRI';
  S3 := 'MOHAMED EL AMINE';
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  S2 := 'DALLAA';
  S3 := 'ABDSAMED TAKI EDDINE';
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  S2 := 'BOUCHETA';
  S3 := 'ZAHRA';
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  ///2CPI
  S2 := 'REZAZI';
  S3 := 'MOHAMED ABDSAMMED';
  ClassYear := 2;
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  S2 := 'BEN KHAOUA';
  S3 := 'OUSSAMA';
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  S2 := 'ROUBACH';
  S3 := 'ISLAM';
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  S2 := 'FETTACH';
  S3 := 'DINA';
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  S2 := 'BELARBI';
  S3 := 'CHIFA REBEL';
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  S2 := 'SERRADJ';
  S3 := 'MOHAMED EL AMINE';
  NewStudent(S2,S3,ClassYear,SpecialitySearch(S1));
  Writeln('Added Succesfully!');
End;

///STARTING OF THE PRINCIPAL PROGRAM
Var
  G,ClassYear: Integer; // G IS A VARIABLE TO CHOOSE OPERATION NUMBER, AND THE CLASSYEAR FOR CHOOSING THE YEAR THE STUDENT WILL BE ADDED TO
  Input1,Input2,Input3: String[30]; //INPUTS WE NEED IN DEFFERENT FUNCTIONS ENTRIES, GENERALLY INPUT1 FOR THE PREVIOUS SECTION ADDED TO AND INPUT2 FOR THE NEXT SECTION TO ADD
Begin
  StartPointer := Nil;
  Writeln('Welcome to our University Guid TP! Hit Enter To Start');
  Readln;
  Repeat
    Writeln('choose one of the following functions to execute : ');
    Writeln('0. Quit Our University Guid TP!');
    Writeln('1. Create a University.');
    Writeln('2. Create a Faculty On a University');
    Writeln('3. Create a Department On a Faculty');
    Writeln('4. Create a Speciality On a Department');
    Writeln('5. Create a Student On a Speciality');
    Writeln('6. Search For a Faculty');
    Writeln('7. Search For a Department');
    Writeln('8. Search For a Speciality');
    Writeln('9. Search For a Student On a University');
    Writeln('10. Delete Faculty If No Student In');
    Writeln('11. Delete Department If No Student In');
    Writeln('12. Delete Speciality If No Student In');
    Writeln('13. Delete Student In a Year Of a Speciality On a Department');
    Writeln('14. Sort Students per Year Of a Speciality On a Department');
    Writeln('15. Search For a University');
    Writeln('20. Enter TEMPLATE1 Data');
    Writeln('99. Show Result Of Total Registries');
    Writeln;
    Writeln('Select The Operation You Want');
    Readln(G);
    Case G Of
      1:
         Begin
           Writeln('Enter The University Name');
           Readln(Input1);
           NewUniversity(Input1);
         End;
      2:
         Begin
           Writeln('Enter The University Name');
           Readln(Input1);
           Writeln('Enter The Faculty Name');
           Readln(Input2);
           NewFaculty(Input2, UniversitySearch(Input1));
         End;
      3:
         Begin
           Writeln('Enter The Faculty Name');
           Readln(Input1);
           Writeln('Enter The Department Name');
           Readln(Input2);
           NewDepartment(Input2, FacultySearch(Input1));
         End;
      4:
         Begin
           Writeln('Enter The Department Name');
           Readln(Input1);
           Writeln('Enter The Speciality Name');
           Readln(Input2);
           NewSpeciality(Input2, DepartmentSearch(Input1));
         End;
      5:
         Begin
           Writeln('Enter The Speciality Name');
           Readln(Input1);
           Writeln('Enter Student''s First Name');
           Readln(Input2);
           Writeln('Enter Student''s Last Name');
           Readln(Input3);
           Writeln('Enter Student''s Year');
           Readln(ClassYear);
					 Repeat
             Writeln('Year Is Incorrect Try Again');
             readln(ClassYear);
           Until ((ClassYear<=5) and (ClassYear>0));
           NewStudent(Input2,Input3,ClassYear,SpecialitySearch(Input1));
         End;
      6:
         Begin
           Writeln('Enter The Faculty You Want To Search About');
           Readln(Input1);
           If (FacultySearch(Input1)<>Nil) Then
             Writeln('The Faculty You Searched For Exists')
           Else
             Writeln('The Faculty You Searched For Doesn''t Exist');
         End;
      7:
         Begin
           Writeln('Enter The Department You Want To Search About');
           Readln(Input1);
           If (DepartmentSearch(Input1)<>Nil) Then
             Writeln('The Department You Searched For Exists')
           Else
             Writeln('The Department You Searched For Doesn''t Exist');
         End;
      8:
         Begin
           Writeln('Enter The Speciality You Want To Search About');
           Readln(Input1);
           If (SpecialitySearch(Input1)<>Nil) Then
             Writeln('The Speciality You Searched For Exists')
           Else
             Writeln('The Speciality You Searched For Doesn''t Exist');
         End;
      9:
         Begin
           Writeln('Enter The Student''s FirstName You Want To Search About');
           Readln(Input1);
           Writeln('Enter The Student''s LastName You Want To Search About');
           Readln(Input2);
           If (StudentSearch(Input1,input2)<>Nil) Then
             Writeln('The Student You Searched For Exists')
           Else
             Writeln('The Student You Searched For Doesn''t Exist');
         End;
      10:
          Begin
            Writeln('Enter The University''s Of The Faculty You Want To Delete');
            Readln(Input1);
            Writeln('Enter The Faculty You Want To Delete');
            Readln(Input2);
            DeleteFaculty(Input2,UniversitySearch(Input1));
          End;
      11:
          Begin
            Writeln('Enter The Faculty''s Of The Department You Want To Delete');
            Readln(Input1);
            Writeln('Enter The Department You Want To Delete');
            Readln(Input2);
            DeleteDepartment(Input2,FacultySearch(Input1));
          End;
      12:
          Begin
            Writeln('Enter The Department''s Of The Speciality You Want To Delete');
            Readln(Input1);
            Writeln('Enter The Speciality You Want To Delete');
            Readln(Input2);
            DeleteSpeciality(Input2,DepartmentSearch(Input1));
          End;
      13:
          Begin
            Writeln('Enter The Student''s First Name');
            Readln(Input1);
            Writeln('Enter The Student''s Last Name');
            Readln(Input2);
            Writeln('Enter The Student''s Study Year');
            Readln(ClassYear);
            DeleteStudent(Input1,Input2,ClassYear);
          End;
      14:
          Begin
            Writeln('Enter The Department Name');
            Readln(Input1);
            Writeln('Enter The Speciality Name');
            Readln(Input2);
            SortStudents(Input2,Input1);
          End;
      20: TEMPLATE1;
      15:
          Begin
            Writeln('Enter The University You Want To Search About');
            Readln(Input1);
            If (UniversitySearch(Input1)<>Nil) Then
              Writeln('The University You Searched For Exists')
            Else
              Writeln('The University You Searched For Doesn''t Exist');
          End;
      99: ShowResult(StartPointer);
    End;
  Until (G=0);
  Writeln('Thank You For Using Our University Guid TP!, Have a Nice Day.');
  Readln;
End.