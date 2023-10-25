import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.1


Window {
    width: 2560
    height: 1600
    visible: true
    title: qsTr("Todo List")
    property string time: Qt.formatTime(new Date(),"hh:mm")
    property string date: Qt.formatDateTime(new Date(), "dddd d MMMM yyyy")


    ListModel {
        id: todoModel
    }

    Item {
        anchors.fill: parent

        Rectangle {
            id: top
            height: 40
            width: parent.width
            color: black
            anchors.top: parent.top
            ColorAnimation on color { to: "#ADD8E6"; duration: 3000;}
        }

        Item {
            width: parent.width
            anchors.bottom: parent.bottom
            anchors.top: top.bottom

            Rectangle {
                id: right
                width: 0.5 * parent.width
                height: parent.height
                anchors.right: parent.right
                color: "white"
                Rectangle {
                    height: parent.height
                    width: 10
                    color: "#ADD8E6"
                    anchors.top: parent.top
                    anchors.left: parent.left
                }

                Text {
                    id: listText
                    text: qsTr("YOUR TODO LIST IS EMPTY!")
                    x: 170
                    y: 100
                    font.pointSize: 28
                    font.family: "Comic Sans MS"
                    font.bold: true
                    color: "white"
                    ColorAnimation on color { to: "black"; duration: 3000;}

                }

                Image {
                    id:coffee
                    width: 400
                    height: 400
                    x: 170
                    y: 200
                    source: "file:///Users/scarlet/todoList2.0/coffee.jpg";
                }

                Text {
                    id: listVisible
                    text: qsTr("YOUR TODO LIST FOR TODAY")
                    x: 170
                    y: 20
                    font.pointSize: 28
                    font.weight: bold
                    font.family: "Comic Sans MS"
                    font.bold: true
                    visible: false
                }

                ListView {
                    id: lv
                    model: todoModel
                    spacing: 12
                    anchors.centerIn: parent
                    anchors.topMargin: 250
                    width: 700
                    height: parent.height * 0.75
                    ScrollBar.vertical: ScrollBar {
                        id: scroll
                        policy: ScrollBar.AlwaysOn
                        visible: lv.count > 7
                        background: Rectangle {
                            color: "white"
                        }
                    }

                    delegate: Rectangle {
                        id: dlg
                        width: 600
                        height: 60
                        color: "white"
                        radius: 10
                        border.color: "black"
                        border.width: 1.2
                        x: 50
                        property string description
                        description: _description

                        CheckBox {
                            id: checkBox
                            text: ""
                            x: 17
                            y: 22
                            scale: 1.3

                            indicator: Rectangle {
                                implicitWidth: 16
                                implicitHeight: 16
                                radius: 3
                                border.width: 1

                                Rectangle {
                                    id: checkMark
                                    visible: false
                                    color: "#a8f3f3"
                                    border.color: "#333"
                                    radius: 1
                                    anchors.margins: 4
                                    anchors.fill: parent
                                }
                            }

                            onClicked: {
                                if(checkMark.visible === true) {
                                    checkMark.visible = false
                                }
                                else if(checkMark.visible === false) {
                                    checkMark.visible = true
                                }
                            }
                        }

                        Image {
                            x: 510
                            y: 10
                            width: 35
                            height: 37
                            source: "file:///Users/scarlet/todoList2.0/pen.png";
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        input.cursorVisible  = true
                                        task.cursorVisible = false
                                    }
                                }
                        }

                        Image {
                            width: 40
                            height: 40
                            x:550
                            y: 8
                            source: "file:///Users/scarlet/todoList2.0/bag.jpg";

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    deletePopup.open()
                                    //deletePopup.visible = true
//                                        todoModel.remove(index)
//                                        if (todoModel.count === 0) {
//                                            coffee.visible = true
//                                            listVisible.visible = false
//                                            listText.visible = true
//                                        }
                                }
                            }
                        }

                        Column {
                            anchors.fill: parent
                            anchors.leftMargin: 20
                            anchors.topMargin: 12
                            anchors.bottomMargin: 5

                            TextInput {
                                id: input
                                x: 25
                                width: 500
                                color: "black"
                                font.pixelSize: 23
                                font.family: "Comic Sans MS"
                                text: dlg.description
                                font.strikeout: checkBox.checked
                                focus: false
                                maximumLength: 950 / (font.pixelSize)
                            }
                        }

                        //Delete remainder
                        Popup {
                            height: 70
                            width: 375
                            padding: 10
                            id: deletePopup
                            modal: true
                            focus: true
                            x: 225
                            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent




                            contentItem: Label {
                                text: "Are you sure you want to delete this Task ?"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 20
                                visible: true
                                color: "red"

                                Row {
                                    x: 125
                                    y: 30
                                    Button {
                                        id: yes
                                        text: qsTr("Yes")
                                        onClicked: {
                                            todoModel.remove(index)
                                            if (todoModel.count === 0) {
                                                coffee.visible = true
                                                listVisible.visible = false
                                                listText.visible = true
                                            }
                                            deletePopup.visible = false
                                        }
                                    }

                                    Button {
                                        id:no
                                        text: qsTr("Cancel")
                                        onClicked: {
                                            deletePopup.visible = false
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item {
                id: inputArea
                width: 0.5 * parent.width
                height: parent.height

                Rectangle {
                    width: parent.width
                    height: parent.height
                    anchors.left: parent.left
                    color: "white"

                    ColorAnimation on color { to: "black"; duration: 3000;}

                    Label {
                        id: header
                        width: 500
                        height: 150
                        x: 50

                        Text {
                            text: qsTr("WHAT IS ON YOUR TODO?")
                            x: 95
                            y: 100
                            font.pointSize: 28
                            font.weight: bold
                            color: "white"
                            font.bold: true
                            font.family: "Comic Sans MS"
                        }

                        Text {
                            text: date
                            x: 65
                            y: 220
                            font.pointSize: 20
                            font.family: "Comic Sans MS"
                            color: "white"
                        }

                        Text {
                            text:time
                            x:450
                            y: 220
                            font.pointSize: 20
                            font.family: "Comic Sans MS"
                            color: "white"
                        }

                        Timer {
                            id: timer
                            interval: 1000
                            repeat: true
                            running: true

                            onTriggered:{
                                date =  Qt.formatDateTime(new Date(), "dddd d MMMM yyyy")
                                time = Qt.formatTime(new Date(), "hh:mm")
                            }
                        }

                        Rectangle {
                            width: 450
                            height: 60
                            x: 60
                            y: 250
                            radius: 10

                            TextArea {
                                id: task
                                x: 20
                                y: 10
                                placeholderText: "Enter your TODO task"
                                font.pointSize: 20
                                font.family: "Comic Sans MS"
                                width: 400
                                wrapMode: Text.NoWrap
                                onTextChanged: {
                                    if (task.text.indexOf('\n') !== -1) {
                                        task.text = task.text.replace(/\n/g, '');
                                    }
                                }
                            }
                        }

                        Button {
                            text: "ADD TODO"
                            height: 50
                            x: 65
                            y: 350
                            width: 250
                            font.pointSize: 18
                            font.family: "Comic Sans MS"
                            font.bold: true

                            background:
                            Rectangle {
                                id: add
                                color: "#ADD8E6"
                                radius: 10
                                border.width: 1.5
                                border.color: "#ADD8E6"
                            }

                            MouseArea {
                                anchors.fill: parent
                                onPressed: add.color = "white"
                                onReleased: add.color = "#ADD8E6"
                                onClicked: {
                                    if(task.text !== "") {
                                        todoModel.append({"_description": task.text})
                                        task.text = ""
                                        listText.visible = false
                                        coffee.visible = false
                                        listVisible.visible = true
                                    } else {
                                        warningDialog.visible = true
                                    }
                                }
                            }

                            Dialog {
                                id: warningDialog
                                modal: true
                                width: 300
                                height: 80
                                visible: false
                                Rectangle {
                                    anchors.fill: parent
                                    color: "#f34b4b"
                                    border.width: 2
                                    border.color: "white"
                                    radius: 10
                                    Text {
                                        text: "Please enter TODO task!"
                                        anchors.centerIn: parent
                                        font.pointSize: 20
                                        color: "white"
                                        font.family: "Comic Sans MS"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}










































