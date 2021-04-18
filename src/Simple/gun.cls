Class Simple.Gun Extends %Persistent
{

/// Gun number
Property Number As %Integer;

/// Gun label (Gun model)
Property Label As %String;

/// Gun type
Property Type As %String;

/// Create a new Gun<br>
/// <var>Number</var> - Gun number<br>
/// <var>Label</var> - Gun label or model<br>
/// <var>Type</var> - engine Type<br>
ClassMethod create(Number As %Integer, Label As %String, Type As %String) As Simple.Gun
{
    set Gun = ..%New()
    set Gun.Number = Number
    set Gun.Label = Label
    set Gun.Type = Type
    set st =  Gun.%Save()
    return Gun
}

/// Save request object to table
/// <var>reqObj</var> - request object
ClassMethod add(reqObj) As %DynamicArray
{
  set result = {}
  set obj = ..%New()
  set obj.Number = reqObj.Get("number")
  set obj.Label = reqObj.Get("label")
  set obj.Type = reqObj.Get("Type")
  set saveResult = obj.%Save()
  
  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  return result.%ToJSON()
}

/// Get all Guns from the table
ClassMethod getAll() As %DynamicArray
{
    set Guns = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM Simple.Gun")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "number": (data.Number),
            "label": (data.Label),
            "Type": (data.Type)
        }
        do Guns.%Push(obj)
    }
    return Guns.%ToJSON()
}

/// Get Gun number and label list for select editor
ClassMethod getSelectList() As %DynamicArray
{
    set Guns = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM Simple.Gun")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "value": (data.Number_" "_data.Label)
        }
        do Guns.%Push(obj)
    }
    return Guns.%ToJSON()
}

/// Edit Gun
/// <var>reqObj</var> - request obj
ClassMethod edit(reqObj) As %DynamicArray
{
    set Id = reqObj.Get("id")
    set Gun = ..%OpenId(Id)
    set result = {}

    if $IsObject(Gun) {
        set Gun.Number = reqObj.Get("number")
        set Gun.Label = reqObj.Get("label")
        set Gun.Type = reqObj.Get("Type")
        set saveResult = Gun.%Save()
        if $$$ISOK(saveResult) set result = {"result": true}
        else  set result = {"result": false}
        set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
        set result.message = ErrorMessage
    }
    else {
        set result = {"result": false}
        set result.message = "Invalid object"
    }
    
    return result.%ToJSON()
}

/// Delete Gun from table by id
/// <var>Id</var> - Gun id in the table
ClassMethod delete(Id As %String = "") As %DynamicArray
{
    set deleteResult = ..%DeleteId(Id)
    set result = {}
    if $$$ISOK(deleteResult) set result = {"result": true}
    else  set result = {"result": false}
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(deleteResult)
    set result.message = ErrorMessage
    return result.%ToJSON()
}

Storage Default
{
<Data name="GunDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Number</Value>
</Value>
<Value name="3">
<Value>Label</Value>
</Value>
<Value name="4">
<Value>Type</Value>
</Value>
</Data>
<DataLocation>^Simple.GunD</DataLocation>
<DefaultData>GunDefaultData</DefaultData>
<IdLocation>^Simple.GunD</IdLocation>
<IndexLocation>^Simple.GunI</IndexLocation>
<StreamLocation>^Simple.GunS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
