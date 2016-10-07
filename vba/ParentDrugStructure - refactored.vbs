Option Explicit

Global INSTRUCTION, VOLUME, UNITS, ADDITIONALNOTES, POPULATION, INDICATIONPRN, STRENGTH, FREQUENCY As Integer
Global BACKGROUNDINFORMATION, PRNINFORMATION, AHSFORMULARYSTATUS, AHFSNAME, HIGHALERT, DOSE, ROUTE, FORM As Integer
Global DRUG, MAXIMUMPRNDOSE As Integer

Global gStore(50, 150)
Global gElementNames(50)
Global gColumnMap(50)
Global gCurrentElementValue(50)
Global gElementCount As Integer
Function Setup()
    
    'TODO: Add in Maximum PRN Dose

  gElementCount = 0
    
  SetElement DOSE, gElementCount + 1, "DOSE", "S"
  SetElement ROUTE, gElementCount + 1, "ROUTE", "U"
  SetElement FORM, gElementCount + 1, "FORM", "O"
  SetElement DRUG, gElementCount + 1, "DRUG", "BE"
  SetElement STRENGTH, gElementCount + 1, "strength", "M"
  SetElement FREQUENCY, gElementCount + 1, "frequency", "V"
  SetElement INSTRUCTION, gElementCount + 1, "INSTRUCTION", "Y"
  SetElement VOLUME, gElementCount + 1, "VOLUME", "N"
  SetElement UNITS, gElementCount + 1, "UNITS", "T"
  SetElement ADDITIONALNOTES, gElementCount + 1, "ADDITIONALNOTES", "AB"
  SetElement POPULATION, gElementCount + 1, "POPULATION", "AA"
  SetElement INDICATIONPRN, gElementCount + 1, "INDICATIONPRN", "X"
  SetElement BACKGROUNDINFORMATION, gElementCount + 1, "BACKGROUNDINFORMATION", "AH"
  SetElement PRNINFORMATION, gElementCount + 1, "PRNINFORMATION", "W"
  SetElement AHSFORMULARYSTATUS, gElementCount + 1, "AHSFORMULARYSTATUS", "K"
  SetElement AHFSNAME, gElementCount + 1, "AHFSNAME", "AL"
  SetElement HIGHALERT, gElementCount + 1, "HIGHALERT", "AF"
  SetElement MAXIMUMPRNDOSE, gElementCount + 1, "MAXIMUMPRNDOSE", "AF"
  
End Function

Function inArray(iArray, value)
Dim found: found = False
Dim i As Integer

For i = 0 To UBound(iArray)
If iArray(i) = value Then

found = True
Exit For ' prevents searching the whole array...
End If
Next
inArray = found
End Function



Function HTML_Encode(iString)
  Dim i As Integer
  
  Dim tmp As String
  tmp = iString
 ' For i = 160 To 255
 '   tmp = Replace(tmp, Chr(i), "&#" & i & ";")
 ' Next
  tmp = Replace(tmp, Chr(34), "&quot;")
  tmp = Replace(tmp, Chr(39), "&apos;")
  tmp = Replace(tmp, Chr(60), "&lt;")
  tmp = Replace(tmp, Chr(62), "&gt;")
  tmp = Replace(tmp, Chr(38), "&amp;")
  'tmp = Replace(tmp, Chr(32), "&nbsp;")
  HTML_Encode = tmp
End Function

Function ClearLists()
  
  Dim i As Integer
  For i = 0 To 150
    gStore(0, i) = 0
  Next

End Function
Function AddItemToList(list, item)

  Dim i, iListIndex As Integer
  Dim found As Boolean
  found = False
 
  
  iListIndex = gStore(0, list) ' get the pointer to the end of the list
 
  For i = 0 To iListIndex ' store only new values
    If gStore(list, i) = item Then
      found = True
      Exit For
    End If
  Next
  
  If Not found Then ' add the item to the list
    iListIndex = iListIndex + 1
    gStore(list, iListIndex) = item ' store the pointer
    gStore(0, list) = iListIndex ' store the new pointer position for the list
  End If

End Function
Function GetElementName(listnumber)
  GetElementName = gStore(listnumber, 0)
End Function
Sub SetElement(ByRef item, listnumber, name, column)
  item = listnumber
  gStore(listnumber, 0) = LCase(name)
  gColumnMap(listnumber) = column
  gElementCount = gElementCount + 1
End Sub


Sub ExportToXML()
    
    Dim sh As Worksheet
    Dim rw As Range
    
    Dim objFSO, objFile, objFSO_index, objFile_index As Variant
    Dim iList, CurrentListPointer, iElement, RowCount As Integer
    Dim sHTMLDirectory, sModelDirectory, CurrentElement As String
    Dim LastDrug, LastForm As String
    
    LastDrug = ""
    LastForm = ""
    RowCount = 0
    
    sModelDirectory = "D:\Catalogues\xml\pharmacy\"
    sHTMLDirectory = "D:\Catalogues\web\html\"
    
    Set objFSO_index = CreateObject("Scripting.FileSystemObject")
    Set objFile_index = objFSO_index.CreateTextFile(sHTMLDirectory + "ckt-drug-tablelines.html", True)
    
    Setup
    
    Set sh = ActiveSheet
    For Each rw In sh.Rows
    
        LastDrug = gCurrentElementValue(DRUG)
        LastForm = gCurrentElementValue(FORM)
        
        For iList = 1 To gElementCount
          gCurrentElementValue(iList) = HTML_Encode(sh.Cells(rw.Row, Range(gColumnMap(iList) & 1).column).value)
        Next
        
        'If Not (CurrentDrug = LastDrug And CurrentForm = LastForm) And LastDrug <> "" Then 'new drugform
        If Not (gCurrentElementValue(DRUG) = LastDrug) And LastDrug <> "" And RowCount <> 1 Then
             ' write out last drug
             
            Set objFSO = CreateObject("Scripting.FileSystemObject")
            'outFile = "c:\test\" + Replace(LastDrug, "\", "") + " " + Replace(LastForm, "\", "") + ".xml"
    
            Set objFile = objFSO.CreateTextFile(sModelDirectory + Replace(LastDrug, "/", "") + ".xml", True)
    
            'objFile_index.Write "<tr><td><a href=" + Chr(34) + "./" + Replace(LastDrug, "/", "") + " " + Replace(LastForm, "/", "") + ".xml" + Chr(34) + ">" + LastDrug + " " + LastForm + "</a><br></td></tr>" & vbCrLf ' link to model
            objFile_index.Write "<tr><td><a href=" + Chr(34) + "./" + Replace(LastDrug, "/", "") + ".xml" + Chr(34) + ">" + LastDrug + "</a><br></td></tr>" & vbCrLf ' link to model
            
            objFile.Write "<?xml version=" + Chr(34) + "1.0" + Chr(34) + "?>"
            objFile.Write "<?xml-stylesheet type=" + Chr(34) + "text/xsl" + Chr(34) + " href=" + Chr(34) + "../web/xslt/drug-table.xslt" + Chr(34) + "?>"
            objFile.Write "<drug name = " + Chr(34) + LastDrug + " " + LastForm + Chr(34) + ">" & vbCrLf
                  
            ' write out elements
            For iList = 1 To gElementCount
              
              ' get the list pointer for each list
              CurrentListPointer = gStore(0, iList)
              ' get the xml element name for the list
              CurrentElement = GetElementName(iList)
              
              objFile.Write "<" + CurrentElement + ">"
                        
              ' iterate through each list to get the element values
              For iElement = 1 To CurrentListPointer
                objFile.Write "<value>" & gStore(iList, iElement) & "</value>" & vbCrLf
              Next
              
              objFile.Write "</" + CurrentElement + ">"
              
            Next
            ClearLists
     
    
            objFile.Write "</drug>"
    
            objFile.Close
    
        End If
      
        For iList = 1 To gElementCount
           AddItemToList iList, gCurrentElementValue(iList)
        Next
                
        RowCount = RowCount + 1
        If gCurrentElementValue(DRUG) = "" Then Exit For
    
    Next rw
    
    objFile_index.Close
    
    MsgBox (RowCount)
End Sub



