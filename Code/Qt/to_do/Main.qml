import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 640
    height: 480
    visible: true
    title: "待办清单"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            TextField {
                id: inputField
                Layout.fillWidth: true
                placeholderText: "请输入待办事项"
                onAccepted: addButton.clicked()
            }

            Button {
                id: addButton
                text: "添加"
                onClicked: {
                    if (inputField.text.trim() !== "") {
                        todoListModel.append({"text": inputField.text.trim()})
                        inputField.text = ""
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 20

            // 待办事项列表
            ListView {
                id: todoList
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width / 2
                model: ListModel { id: todoListModel }
                delegate: ItemDelegate {
                    width: todoList.width
                    text: model.text
                    onClicked: {
                        doneListModel.append({"text": model.text})
                        todoListModel.remove(index)
                    }
                }

                ScrollBar.vertical: ScrollBar {}
            }

            // 已完成列表
            ListView {
                id: doneList
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width / 2
                model: ListModel { id: doneListModel }
                delegate: ItemDelegate {
                    width: doneList.width
                    text: model.text
                    onClicked: {
                        todoListModel.append({"text": model.text})
                        doneListModel.remove(index)
                    }
                }

                ScrollBar.vertical: ScrollBar {}
            }
        }
    }
}
