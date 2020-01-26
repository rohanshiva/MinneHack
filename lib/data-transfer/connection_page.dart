import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minne_hack/contact/contact_page.dart';
import 'package:minne_hack/data-transfer/components/transfer_comp.dart';
import 'bloc/data_transfer_bloc.dart';
import 'bloc/data_transfer_state.dart';
import 'components/wait_comp.dart';

class ConnectionPage extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
        body: BlocProvider(
        child: ConnectionPageComponent(),
        builder: (context)=> DataTransferBloc(),
      ),
    );
  }
}

class ConnectionPageComponent extends StatelessWidget{

  
  Widget build(BuildContext context){
    return BlocListener(
      bloc: BlocProvider.of<DataTransferBloc>(context),
      listener: (BuildContext context, DataTransferState state){
        if(state is ProfileState){
          return Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=> null
          ));
        }
        else if(state is ContactState){

          Navigator.of(context).pop();
          return Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=> ContactPage()
          ));
        }
        return Container();
      },
      child: BlocBuilder(
        bloc: BlocProvider.of<DataTransferBloc>(context),
        builder: (BuildContext context, DataTransferState state){

          if(state is WaitState){
            return WaitComponent();
          }
          else if(state is TransferState){
            return TransferComponent();
          }
        },
      ),
    );
  }
}