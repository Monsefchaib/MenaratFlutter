// ---------------- Time
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Expanded(
//       child: TextFormField(
//         validator: (date) {
//           if (isDateValid(date!)) return null;
//           else
//             return 'Entrez une date valide';
//         },
//         readOnly: true,
//         showCursor: false,
//         enableInteractiveSelection: true,
//         controller: _timeStartController,
//         decoration: InputDecoration(
//           suffixIcon:  IconButton(icon: Icon(Icons.access_time), onPressed:()=>_selectTime("start"),),
//           labelText: "Heure de démarrage de l'opération",
//           border: OutlineInputBorder(),
//         ),
//       ),
//     ),
//     SizedBox(width: 10,),
//     Expanded(
//       child: TextFormField(
//         validator: (date) {
//           if (isDateValid(date!)) return null;
//           else
//             return 'Entrez une date valide';
//         },
//         readOnly: true,
//         showCursor: false,
//         enableInteractiveSelection: true,
//         controller: _timeFinishController,
//         decoration: InputDecoration(
//           suffixIcon:  IconButton(icon: Icon(Icons.access_time), onPressed:()=>_selectTime("finish"),),
//           labelText: "Heure de fin de l'opération",
//           border: OutlineInputBorder(),
//         ),
//
//       ),
//     ),
//   ],
// ),