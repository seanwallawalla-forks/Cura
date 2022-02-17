import QtQuick 2.10
import QtQuick.Controls 2.2
import QtQuick.Window 2.1
import QtQuick.Layouts 1.1

import UM 1.5 as UM
import Cura 1.1 as Cura


/*
*   A dialog that provides the option to pick a color. Currently it only asks for a hex code and shows the color
*   in a color swath
*/
UM.Dialog
{
    id: base

    property variant catalog: UM.I18nCatalog { name: "cura" }

    minimumHeight: UM.Theme.getSize("small_popup_dialog").height
    minimumWidth: UM.Theme.getSize("small_popup_dialog").width / 1.5
    height: minimumHeight
    width: minimumWidth

    property alias color: colorInput.text

    margin: UM.Theme.getSize("default_margin").width
    buttonSpacing: UM.Theme.getSize("default_margin").width

    UM.Label
    {
        id: colorLabel
        font: UM.Theme.getFont("large")
        text: catalog.i18nc("@label", "Color Code (HEX)")
    }

    TextField
    {
        id: colorInput
        text: "#FFFFFF"
        selectByMouse: true
        anchors.top: colorLabel.bottom
        anchors.topMargin: UM.Theme.getSize("default_margin").height
        onTextChanged: {
            if (!text.startsWith("#"))
            {
                text = `#${text}`;
            }
        }
        validator: RegExpValidator { regExp: /^#([a-fA-F0-9]{0,6})$/ }
    }

    Rectangle
    {
        id: swatch
        color: base.color
        anchors.leftMargin: UM.Theme.getSize("default_margin").width
        anchors {
            left: colorInput.right
            top: colorInput.top
            bottom: colorInput.bottom
        }
        width: height
    }

    rightButtons:
    [
        Cura.PrimaryButton {
            text: catalog.i18nc("@action:button", "OK")
            onClicked: base.accept()
        },
        Cura.SecondaryButton {
            text: catalog.i18nc("@action:button", "Cancel")
            onClicked: base.close()
        }
    ]
}