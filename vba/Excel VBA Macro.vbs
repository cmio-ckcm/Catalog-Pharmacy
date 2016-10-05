Option Explicit

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



Sub ExportToXML()

Dim sModelDirectory As String
Dim sHTMLDirectory As String

Dim sh As Worksheet
Dim rw As Range
Dim RowCount As Integer
Dim LastDrug, LastForm, CurrentDrug, CurrentForm, CurrentStrength, CurrentDose, CurrentFrequency As String
Dim CurrentInstruction, CurrentVolume, Currentunits As String
Dim Currentroute As String

Dim objFSO_index, objFile_index As Variant
Dim objFSO, objFile As Variant

Dim arraysize, i As Integer


Dim iDose As Integer
Dim Doses(150)
iDose = 0

Dim iroute As Integer
Dim routes(50)
iroute = 0

Dim ifrequency As Integer
Dim frequencys(50)
ifrequency = 0

Dim istrength As Integer
Dim strengths(50)
istrength = 0


Dim ivolume As Integer
Dim volumes(50)
ivolume = 0

Dim iinstruction As Integer
Dim instructions(150)
iinstruction = 0


Dim iunits As Integer
Dim unitss(50)
iunits = 0


Dim CurrentAdditionalNotes As String
Dim iAdditionalNotes As Integer
Dim AdditionalNotess(50)
iAdditionalNotes = 0

Dim CurrentPopulation As String
Dim iPopulation As Integer
Dim Populations(50)
iPopulation = 0

Dim CurrentIndicationPRN As String
Dim iIndicationPRN As Integer
Dim IndicationPRNs(50)
iIndicationPRN = 0

Dim CurrentBackgroundInformation As String
Dim iBackgroundInformation As Integer
Dim BackgroundInformations(50)
iBackgroundInformation = 0

Dim CurrentHighAlert As String
Dim iHighAlert As Integer
Dim HighAlerts(50)
iHighAlert = 0


Dim CurrentPRNInformation As String
Dim iPRNInformation As Integer
Dim PRNInformations(50)
iPRNInformation = 0

Dim CurrentAHSFormularyStatus As String
Dim iAHSFormularyStatus As Integer
Dim AHSFormularyStatuss(50)
iAHSFormularyStatus = 0

Dim CurrentAHFSName As String
Dim iAHFSName As Integer
Dim AHFSNames(50)
iAHFSName = 0

LastDrug = ""
LastForm = ""

RowCount = 0

sModelDirectory = "D:\Catalog-Pharmacy\xml\"
sHTMLDirectory = "D:\Catalog-Pharmacy\web\html\"

Set objFSO_index = CreateObject("Scripting.FileSystemObject")
Set objFile_index = objFSO_index.CreateTextFile(sHTMLDirectory + "xml-models.html", True)


Set sh = ActiveSheet
For Each rw In sh.Rows

    LastDrug = CurrentDrug
    LastForm = CurrentForm
    
    ' column refs current at 4th oct 2016 [7b0f80733c13c81d0eeaf0623cb7971181b17001 github]
   
    CurrentDrug = RTrim(sh.Cells(rw.Row, Range("E" & 1).Column).value)
    CurrentForm = RTrim(sh.Cells(rw.Row, Range("O" & 1).Column).value)
    
    If CurrentDrug = "tamoxifen" Then
   '     MsgBox ("")
    End If
        
        
    
    'TODO: Add in Maximum PRN Dose
   
    CurrentDose = HTML_Encode(sh.Cells(rw.Row, Range("S" & 1).Column).value)
    Currentroute = HTML_Encode(sh.Cells(rw.Row, Range("U" & 1).Column).value)
    CurrentStrength = HTML_Encode(sh.Cells(rw.Row, Range("M" & 1).Column).value)
    CurrentFrequency = HTML_Encode(sh.Cells(rw.Row, Range("V" & 1).Column).value)
    CurrentInstruction = HTML_Encode(sh.Cells(rw.Row, Range("Y" & 1).Column).value)
    CurrentVolume = HTML_Encode(sh.Cells(rw.Row, Range("N" & 1).Column).value)
    Currentunits = HTML_Encode(sh.Cells(rw.Row, Range("T" & 1).Column).value)
    CurrentAdditionalNotes = HTML_Encode(sh.Cells(rw.Row, Range("AB" & 1).Column).value)
    CurrentPopulation = HTML_Encode(sh.Cells(rw.Row, Range("AA" & 1).Column).value)
    CurrentIndicationPRN = HTML_Encode(sh.Cells(rw.Row, Range("X" & 1).Column).value)
    CurrentBackgroundInformation = HTML_Encode(sh.Cells(rw.Row, Range("AH" & 1).Column).value)
    CurrentPRNInformation = HTML_Encode(sh.Cells(rw.Row, Range("W" & 1).Column).value)
    CurrentAHSFormularyStatus = sh.Cells(rw.Row, Range("K" & 1).Column).value
    CurrentAHSFormularyStatus = HTML_Encode(CurrentAHSFormularyStatus)
    CurrentAHFSName = HTML_Encode(sh.Cells(rw.Row, Range("AL" & 1).Column).value)
    CurrentHighAlert = HTML_Encode(sh.Cells(rw.Row, Range("AF" & 1).Column).value)
    
    If Not (CurrentDrug = LastDrug And CurrentForm = LastForm) And LastDrug <> "" Then 'new drugform
         ' write out last drug
         
        Set objFSO = CreateObject("Scripting.FileSystemObject")
        'outFile = "c:\test\" + Replace(LastDrug, "\", "") + " " + Replace(LastForm, "\", "") + ".xml"

        Set objFile = objFSO.CreateTextFile(sModelDirectory + Replace(LastDrug, "/", "") + " " + Replace(LastForm, "/", "") + ".xml", True)

        objFile_index.Write "<tr><td><a href=" + Chr(34) + "./" + Replace(LastDrug, "/", "") + " " + Replace(LastForm, "/", "") + ".xml" + Chr(34) + ">" + LastDrug + " " + LastForm + "</a><br></td></tr>" & vbCrLf ' link to model

        objFile.Write "<?xml version=" + Chr(34) + "1.0" + Chr(34) + "?>"
        objFile.Write "<?xml-stylesheet type=" + Chr(34) + "text/xsl" + Chr(34) + " href=" + Chr(34) + "drug-table.xslt" + Chr(34) + "?>"
        
        objFile.Write "<drug name = " + Chr(34) + LastDrug + " " + LastForm + Chr(34) + ">" & vbCrLf
        
        objFile.Write "<dose>"
        For i = 1 To iDose
           objFile.Write "<value>" & Doses(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</dose>" & vbCrLf
        iDose = 0
        Erase Doses
        
        objFile.Write "<route>"
        For i = 1 To iroute
           objFile.Write "<value>" & routes(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</route>" & vbCrLf
        iroute = 0
        Erase routes
        
        objFile.Write "<strength>"
        For i = 1 To istrength
           objFile.Write "<value>" & strengths(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</strength>" & vbCrLf
        istrength = 0
        Erase strengths
        
        objFile.Write "<frequency>"
        For i = 1 To ifrequency
           objFile.Write "<value>" & frequencys(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</frequency>" & vbCrLf
        ifrequency = 0
        Erase frequencys
        
        objFile.Write "<instruction>"
        For i = 1 To iinstruction
           objFile.Write "<value>" & instructions(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</instruction>" & vbCrLf
        iinstruction = 0
        Erase instructions
        
        objFile.Write "<volume>"
        For i = 1 To ivolume
           objFile.Write "<value>" & volumes(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</volume>" & vbCrLf
        ivolume = 0
        Erase volumes
      
      
        objFile.Write "<units>"
        For i = 1 To iunits
           objFile.Write "<value>" & unitss(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</units>" & vbCrLf
        iunits = 0
        Erase unitss
      
        objFile.Write "<Population>"
        For i = 1 To iPopulation
           objFile.Write "<value>" & Populations(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</Population>" & vbCrLf
        iPopulation = 0
        Erase Populations
      
        objFile.Write "<IndicationPRN>"
        For i = 1 To iIndicationPRN
           objFile.Write "<value>" & IndicationPRNs(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</IndicationPRN>" & vbCrLf
        iIndicationPRN = 0
        Erase IndicationPRNs
      
      
        objFile.Write "<AdditionalNotes>"
        For i = 1 To iAdditionalNotes
           objFile.Write "<value>" & AdditionalNotess(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</AdditionalNotes>" & vbCrLf
        iAdditionalNotes = 0
        Erase AdditionalNotess
        
        objFile.Write "<BackgroundInformation>"
        For i = 1 To iBackgroundInformation
           objFile.Write "<value>" & BackgroundInformations(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</BackgroundInformation>" & vbCrLf
        iBackgroundInformation = 0
        Erase BackgroundInformations
      
        
        objFile.Write "<PRNInformation>"
        For i = 1 To iPRNInformation
           objFile.Write "<value>" & PRNInformations(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</PRNInformation>" & vbCrLf
        iPRNInformation = 0
        Erase PRNInformations
              
        objFile.Write "<AHSFormularyStatus>"
        For i = 1 To iAHSFormularyStatus
           objFile.Write "<value>" & AHSFormularyStatuss(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</AHSFormularyStatus>" & vbCrLf
        iAHSFormularyStatus = 0
        Erase AHSFormularyStatuss
        
        objFile.Write "<AHFSName>"
        For i = 1 To iAHFSName
           objFile.Write "<value>" & AHFSNames(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</AHFSName>" & vbCrLf
        iAHFSName = 0
        Erase AHFSNames
        
        
        objFile.Write "<HighAlert>"
        For i = 1 To iHighAlert
           objFile.Write "<value>" & HighAlerts(i) & "</value>" & vbCrLf
        Next
        objFile.Write "</HighAlert>" & vbCrLf
        iHighAlert = 0
        Erase HighAlerts
                    
        
        objFile.Write "</drug>"
        
        ' How to write file
        'objFile.Write "test string" & vbCrLf
        objFile.Close
         
        
    End If
  
    If Not (inArray(Doses, CurrentDose)) Then
       ' add to this drugs info
       iDose = iDose + 1
       Doses(iDose) = CurrentDose
    End If
     
    If Not (inArray(routes, Currentroute)) Then
       ' add to this drugs info
       iroute = iroute + 1
       routes(iroute) = Currentroute
    End If
              
    If Not (inArray(strengths, CurrentStrength)) Then
       ' add to this drugs info
       istrength = istrength + 1
       strengths(istrength) = CurrentStrength
    End If
    
    'If (frequencys(ifrequency) <> CurrentFrequency) Then
       ' add to this drugs info
    If Not (inArray(frequencys, CurrentFrequency)) Then
      
       ifrequency = ifrequency + 1
       frequencys(ifrequency) = CurrentFrequency
    End If
                    
    If Not (inArray(instructions, CurrentInstruction)) Then
      
       iinstruction = iinstruction + 1
       instructions(iinstruction) = CurrentInstruction
    End If
                
    If Not (inArray(volumes, CurrentVolume)) Then
      
       ivolume = ivolume + 1
       volumes(ivolume) = CurrentVolume
    End If
                                
              
    If Not (inArray(unitss, Currentunits)) Then
      
       iunits = iunits + 1
       unitss(iunits) = Currentunits
    End If
             
              
    If Not (inArray(Populations, CurrentPopulation)) Then
      
       iPopulation = iPopulation + 1
       Populations(iPopulation) = CurrentPopulation
    End If
             
    
    If Not (inArray(IndicationPRNs, CurrentIndicationPRN)) Then
      
       iIndicationPRN = iIndicationPRN + 1
       IndicationPRNs(iIndicationPRN) = CurrentIndicationPRN
    End If
    
    If Not (inArray(BackgroundInformations, CurrentBackgroundInformation)) Then
      
       iBackgroundInformation = iBackgroundInformation + 1
       BackgroundInformations(iBackgroundInformation) = CurrentBackgroundInformation
    End If
                 
    If Not (inArray(PRNInformations, CurrentPRNInformation)) Then
      
       iPRNInformation = iPRNInformation + 1
       PRNInformations(iPRNInformation) = CurrentPRNInformation
    End If
                 
                                       
    If Not (inArray(HighAlerts, CurrentHighAlert)) Then
      
       iHighAlert = iHighAlert + 1
       HighAlerts(iHighAlert) = CurrentHighAlert
    End If
            
    
    If Not (inArray(AdditionalNotess, CurrentAdditionalNotes)) Then
      
       iAdditionalNotes = iAdditionalNotes + 1
       AdditionalNotess(iAdditionalNotes) = CurrentAdditionalNotes
    End If
    
    If Not (inArray(AHSFormularyStatuss, CurrentAHSFormularyStatus)) Then
      
       iAHSFormularyStatus = iAHSFormularyStatus + 1
       AHSFormularyStatuss(iAHSFormularyStatus) = CurrentAHSFormularyStatus
    End If

    
    If Not (inArray(AHFSNames, CurrentAHFSName)) Then
      
       iAHFSName = iAHFSName + 1
       AHFSNames(iAHFSName) = CurrentAHFSName
    End If


    RowCount = RowCount + 1
    If CurrentDrug = "" Then Exit For
   ' If RowCount > 1000 Then Exit For

Next rw

objFile_index.Close

MsgBox (RowCount)
End Sub


