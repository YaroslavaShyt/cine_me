import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/features/films/data/models/is_success_model.dart';
import 'package:cine_me/features/films/domain/usecases/buy_ticket.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'buy_ticket_state.dart';
part 'buy_ticket_event.dart';

class BuyTicketBloc extends Bloc<BuyTicketEvent, BuyTicketState>{
  final BuildContext context;
  final BoughtTicket boughtTicket;


  BuyTicketBloc({

    required this.boughtTicket,
    required this.context,
  }) : super(BuyTicketInitial());

  @override
  Stream<BuyTicketState> mapEventToState(BuyTicketEvent event) async*{
    if(event is BuyTicketInitiateEvent){
      final response = await boughtTicket(
          sessionId: event.sessionId, seats: event.seats, email: event.email,
          cardNumber: event.cardNumber, cvv: event.cvv, expirationDate: event.expireDate
      );
      yield response.fold((l){
        return BuyTicketError(l.toString());
      }, (r)=> BuyTicketSuccess(r));
    }else if (event is BuyTicketSuccessEvent){
      Beamer.of(context).beamToNamed('/home');
    }
  }

}