Class Simple.Saler Extends %Persistent
{

/// Saler personal number
Property PersNum As %Integer;

/// Saler name
Property Name As %String;

/// Saler Phone 
Property Phone As %String;

/// Create a new Saler<br>
/// <var>Name</var> - Saler name<br>
/// <var>Phone</var> - track Phone<br>
ClassMethod create(Name As %String = "", Phone As %String = "", PersNum As %Integer = 0) As Simple.Saler
{
    set Saler = ..%New()
    set Saler.Name = Name
    set Saler.Phone = Phone
    set Saler.PersNum = PersNum
    set st = Saler.%Save()
    return Saler
}

/// Save a request object to table
/// <var>reqObj</var> - request object
ClassMethod add(reqObj) As %DynamicArray
{
  set result = {}
  set obj = ..%New()
  set obj.Name = reqObj.Get("name")
  set obj.Phone = reqObj.Get("Phone")
  set obj.PersNum = reqObj.Get("PersNum")
  set saveResult = obj.%Save()

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  return result.%ToJSON()
}

/// Get all Salers from the table
ClassMethod getAll() As %DynamicArray
{
    set Salers = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM Simple.Saler")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "name": (data.Name),
            "Phone": (data.Phone),
            "PersNum": (data.PersNum)
        }

        do Salers.%Push(obj)
    }
    return Salers.%ToJSON()
}

/// Get Saler name list for select editor
ClassMethod getNameSelectList() As %DynamicArray
{
    set Salers = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM Simple.Saler")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "value": (data.Name)
        }

        do Salers.%Push(obj)
    }
    return Salers.%ToJSON()
}

/// Edit Saler 
/// <var>reqObj</var> - request object
ClassMethod edit(reqObj) As %DynamicArray
{
    set Id = reqObj.Get("id")
    set Saler = ..%OpenId(Id)
    set result = {}

    if $IsObject(Saler) {
        set Saler.Name = reqObj.Get("name")
        set Saler.Phone = reqObj.Get("Phone")
        set Saler.PersNum = reqObj.Get("PersNum")
        set saveResult = Saler.%Save()

        if $$$ISOK(saveResult) set result = {"result": true}
        else  set result = {"result": false}
        set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
        set result.message = ErrorMessage
    } else {
        set result = {"result": false}
        set result.message = "Invalid Object"
    }
    return result.%ToJSON()
}

/// Delete Saler from table by id
/// <var>Id</var> - Saler id in the table
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
<Data name="SalerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Phone</Value>
</Value>
<Value name="4">
<Value>PersNum</Value>
</Value>
</Data>
<DataLocation>^Simple.SalerD</DataLocation>
<DefaultData>SalerDefaultData</DefaultData>
<IdLocation>^Simple.SalerD</IdLocation>
<IndexLocation>^Simple.SalerI</IndexLocation>
<StreamLocation>^Simple.SalerS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
